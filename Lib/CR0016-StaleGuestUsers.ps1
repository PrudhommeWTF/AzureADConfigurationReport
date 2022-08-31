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
$MonthsToConsiderStale = 18
$Output = @{
    ID                     = 'CR0016'
    Version                = [Version]'1.0.0.0'
    CategoryId             = 1
    Title                  = 'Stale Guest accounts'
    ScriptName             = 'CR0016-StaleGuestUsers'
    Description            = 'This indicator check all guest accounts in Azure AD ensuring that their invitation have been accepted'
    Weight                 = 0
    Severity               = 'Warning'
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

try {
    #region Get all Azure AD Guest Accounts
    $Endpoint         = 'users'
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
        Uri = 'https://graph.microsoft.com/v1.0/{0}?$filter={1}&$select={2}' -f $Endpoint, $AADFilter, ($PropertiesToLoad -join ',') #"https://graph.microsoft.com/v1.0/users?`$filter=userType eq 'Guest'"
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
        $Output.Result.Status      = "Failed"
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
    $Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
}
catch {
    $_ | Write-Error
}
[PSCustomObject]$Output