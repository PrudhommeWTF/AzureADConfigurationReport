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
$Start  = Get-Date
$MonthsToConsiderStale = 18
$Output = @{
    ID                     = 'CR0016'
    ChangeLog              = @(
        [PSCustomObject]@{
            Version   = [Version]'1.0.0.0'
            ChangeLog = 'Initial version'
            Date      = '09/13/2022 21:30'
            Author    = "Thomas Prud'homme"
        }
        [PSCustomObject]@{
            Version   = [Version]'1.0.0.1'
            ChangeLog = @'
Added parameter ReturnScriptMetadata and logic enable main script to pull out $Output content with out running the entire script. In order to allow automated request of Graph API Permission when generating the Azure AD App Registration the first time.
Removed Severity
Added return of $Output in case of Graph API connection failure
'@
            Date      = '09/20/2022 23:30'
            Author    = "Thomas Prud'homme"
        }
    )
    CategoryId             = 1
    Title                  = 'Stale Guest accounts'
    ScriptName             = 'CR0016-StaleGuestUsers'
    Description            = 'This indicator check all guest accounts in Azure AD ensuring that their invitation have been accepted'
    Weight                 = 5
    LikelihoodOfCompromise = 'Attackers that compromise an administrator account could have wide-ranging access across resources.'
    ResultMessage          = "Found {COUNT} Guest accounts that are considered staled (never validated invite or last refresh token older than $MonthsToConsiderStale months)."
    Remediation            = 'Use Azure AD Access Review or Scripts to perform frequent review and cleanup of stale Guests in your environment.'
    Permissions            = @('User.Read.All')
    SecurityFrameworks = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Initial Access')
        }
    )
    Result                 = @{
        Score       = 0
        Status      = ''
        Message     = ''
        Remediation = ''
        Data        = ''
        Timespan    = ''
        GraphAPI    = ''
    }
}

if ($ReturnScriptMetadata) {
    Write-Output -InputObject $Output
    Exit
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
$PropertiesToLoad = @(
    'id'
    'mail'
    'displayName'
    'userPrincipalName'
    'externalUserState'
    'createdDateTime'
    'refreshTokensValidFromDateTime'
)
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

#Filter stale guest accounts
$StaleGuests = $GuestUsers | Where-Object -FilterScript {$_.externalUserState -eq $null -or $_.externalUserState -eq 'PendingAcceptance' -or [DateTime]$_.refreshTokensValidFromDateTime -lt $Start.AddMonths(-$MonthsToConsiderStale)}

if ($StaleGuests.count -gt ($GuestUsers.Count * (1/3))) {
    $Output.Result.Score       = 0
    $Output.Result.Data        = $StaleGuests
    $Output.Result.Message     = $Output.ResultMessage.Replace('{COUNT}',$StaleGuests.count)
    $Output.Result.Remediation = $Output.Remediation
    $Output.Result.Status      = 'Fail'
} elseif ($StaleGuests.count -gt 0) {
    $Output.Result.Score       = 100
    $Output.Result.Data        = $StaleGuests
    $Output.Result.Message     = $Output.ResultMessage.Replace('{COUNT}',$StaleGuests.count)
    $Output.Result.Remediation = "None"
    $Output.Result.Status      = "Pass"
} else {
    $Output.Result.Score       = 100
    $Output.Result.Message     = "No evidence of exposure"
    $Output.Result.Remediation = "None"
    $Output.Result.Status      = "Pass"
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output