[CmdletBinding(
    DefaultParameterSetName = 'Default'
)]
Param(
    [Parameter(
        ParameterSetName = 'GraphAPIAccessToken',
        Mandatory = $true
    )]
    [String]$GraphAPIAccessToken,

    [Parameter(
        ParameterSetName = 'Default',
        Mandatory = $true
    )]
    [String]$TenantId,

    [Parameter(
        ParameterSetName = 'Default',
        Mandatory = $true
    )]
    [String]$TenantAppId,

    [Parameter(
        ParameterSetName = 'Default',
        Mandatory = $true
    )]
    [String]$TenantAppSecret,

    [Parameter(
        ParameterSetName = 'ReturnScriptMetadata'
    )]
    [Switch]$ReturnScriptMetadata
)

#region Init
$Output = @{
    ID         = 'TI0004'
    Version    = [Version]'1.0.0.0'
    ScriptName = 'TI0004-ExternalTenantUsage'
    Result     = ''
}
#endregion Init

#region GraphAPI Connection
try {
    if ($PSCmdlet.ParameterSetName -eq 'Default') {
        $GraphToken = Invoke-RestMethod -Method 'POST' -Uri "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token" -Body @{
            client_id = $TenantAppId
            client_secret = $TenantAppSecret
            scope = 'https://graph.microsoft.com/.default'
            grant_type = 'client_credentials'
        } -ContentType 'application/x-www-form-urlencoded' | Select-Object -ExpandProperty 'access_token'
    } else {
        $GraphToken = $GraphAPIAccessToken
    }
    $Output.Result.GraphAPI = 'Success'
}
catch {
    $_ | Write-Error
    $Output.Result.GraphAPI = "Failed - $($_.Message)"
    [PSCustomObject]$Output
    exit
}
#endregion GraphAPI Connection

#region Main
#region Get all Azure AD Guest Accounts
$AADFilter        = "userType eq 'Guest'"
$PropertiesToLoad = @('mail','userPrincipalName','creationType')
$GetGuestUsers = @{
    Method = 'GET'
    Uri = 'https://graph.microsoft.com/v1.0/users?$filter={0}&$select={1}' -f $AADFilter, ($PropertiesToLoad -join ',')
    ContentType = 'application/json'
    Headers = @{
        Authorization = "Bearer $GraphToken"
    }
}

try {
    $GuestUsersResult = Invoke-RestMethod @GetGuestUsers
}
catch {
    $_ | Write-Error
    Continue
}

$GuestUsers = @($GuestUsersResult.value)

#The 'nextLink' property will keep being returned if there's another page
While ($null -ne $GuestUsersResult.'@odata.nextLink') {
    $GetGuestUsers.Uri = $GuestUsersResult.'@odata.nextLink'
    $GuestUsersResult = Invoke-RestMethod @GetGuestUsers
    $GuestUsers += $GuestUsersResult.value
}
#endregion Get all Azure AD Guest Accounts

$Output.Result = $GuestUsers | ForEach-Object -Process {
    $DomainName = $_.mail.split('@')[1]
    try {
        $TenantInfos = Get-TenantOpenIDConfigInfo -TenantName $DomainName
        [PSCustomObject]@{
            TenantId   = $TenantInfos.authorization_endpoint.split('/')[3]
            Region     = $TenantInfos.tenant_region_scope
            DomainName = $DomainName
        }
    }
    catch {}
} | Group-Object -Property TenantId
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output