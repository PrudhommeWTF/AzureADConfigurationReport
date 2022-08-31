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
    [String]$TenantAppSecret
)

#region Init
$Start  = Get-Date
$Output = @{
    ID         = 'TI0002'
    Version    = [Version]'1.0.0.0'
    ScriptName = 'TI0002-UserAnalysis'
    Result     = @{
        Repartition   = ''
        AnalysisTable = ''
    }
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
    exit
}
#endregion GraphAPI Connection

#region Get all Azure AD Guest Accounts
$Endpoint         = 'users'
$PropertiesToLoad = @(
    'id'
    'userType'
    'onPremisesSyncEnabled'
    'passwordPolicies'
    'passwordProfile'
)
$GetUsers = @{
    Method      = 'GET'
    Uri         = 'https://graph.microsoft.com/v1.0/{0}?$select={1}' -f $Endpoint, ($PropertiesToLoad -join ',')
    ContentType = 'application/json'
    Headers     = @{
        Authorization = "Bearer $GraphToken"
    }
}

try {
    $UsersResult = Invoke-RestMethod @GetUsers
}
catch {
    $_ | Write-Error
    Continue
}

$Users = @($UsersResult.value)

#The 'nextLink' property will keep being returned if there's another page
While ($null -ne $UsersResult.'@odata.nextLink') {
    $GetUsers.Uri = $UsersResult.'@odata.nextLink'
    $UsersResult = Invoke-RestMethod @GetUsers
    $Users += $UsersResult.value
}
#endregion Get all Azure AD Guest Accounts

$Output.Result.Repartition = $Users | Group-Object -Property userType | Select-Object -Property Name,Count
$Output.Result.AnalysisTable = @{
    AccountsCount       = $Users.Count
    GuestAccounts       = ($Users | Where-Object -FilterScript {$_.userType -eq 'Guest'} | Measure-Object).Count
    MemberAccounts      = ($Users | Where-Object -FilterScript {$_.userType -eq 'Member'} | Measure-Object).Count
    SyncedMembers       = ($Users | Where-Object -FilterScript {$_.userType -eq 'Member' -and $_.onPremisesSyncEnabled -eq $true} | Measure-Object).Count
    CloudMembers        = ($Users | Where-Object -FilterScript {$_.userType -eq 'Member' -and $_.onPremisesSyncEnabled -ne $true} | Measure-Object).Count
    CloudPwdNeverExpire = ($Users | Where-Object -FilterScript {$_.onPremisesSyncEnabled -ne $true -and $_.passwordPolicies -eq 'DisablePasswordExpiration'} | Measure-Object).Count
}
$Output.Result.Timespan     = [String](New-TimeSpan -Start $Start -End (Get-Date))

[PSCustomObject]$Output
