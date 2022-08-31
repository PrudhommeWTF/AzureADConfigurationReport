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
    ID                     = 'CR0003'
    Version                = [Version]'1.0.0.0'
    CategoryId             = 1
    Title                  = 'Cloud only account creation'
    ScriptName             = 'CR0003-CloudAccountCreation'
    Description            = 'This indicator will provide information on how frequently are created cloud only accounts'
    Weight                 = 7
    Severity               = 'Critical'
    LikelihoodOfCompromise = 'Cloud only accounts are often less managed than synchronized accounts.'
    ResultMessage          = 'Many cloud accounts are created recently.'
    Remediation            = 'Prefer usage of synchronizer acccounts or be sure to configure Azure MFA and Azure AD Conditional Access with the correct settings to secure them.'
    Permissions            = @('Directory.Read.All')
    SecurityFrameworks     = @(
        @{ Name = 'MITRE ATT&CK'; Tags = @('T1078.004','T1136.003','T1098.001') }
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
[Collections.ArrayList]$CloudAccounts = @()
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

#Check if Organization is using Azure AD Connect. If not, this indicator is useless
try {
    #region Get All AAD Users created within the last 6 months
    $Endpoint = 'users'
    $AADFilter = @(
        "userType eq 'Member'"
        "createdDateTime ge $($Start.AddMonths(-6).ToString('yyyy-MM-ddTHH:mm:ssZ'))"
    )
    $PropertiesToLoad = @(
        'id'
        'userPrincipalName'
        'displayName'
        'createdDateTime'
        'accountEnabled'
        'onPremisesSyncEnabled'
    )
    $GetAADUsers = @{
        Method      = 'GET'
        Uri         = 'https://graph.microsoft.com/v1.0/{0}?$filter={1}&$select={2}' -f $Endpoint, ($AADFilter -join ' and '), ($PropertiesToLoad -join ',')
        ContentType = 'application/json'
        Headers     = @{
            Authorization = "Bearer $GraphToken"
        }
    }

    try {
        $AADUsersResult = Invoke-RestMethod @GetAADUsers
    }
    catch {
        $_ | Write-Error
        Continue
    }

    $AADUsersResponse = @($AADUsersResult.value)

    while ($null -ne $AADUsersResult.'@odata.nextLink') {
        $GetAADUsers.Uri = $AADUsersResult.'@odata.nextLink'
        $AADUsersResult = Invoke-RestMethod @GetAADUsers
        $AADUsersResponse += $AADUsersResult.value
    }
    #endregion Get All AAD Users created within the last 6 months

    #Filter all the synced user objects
    $AADUsersResponse | Where-Object -FilterScript {$_.onPremisesSyncEnabled -eq ''} | ForEach-Object {
        $null = $CloudAccounts.Add(([PSCustomObject][Ordered]@{
            ObjectId          = $_.id
            UserPrincipalName = $_.userPrincipalName
            DisplayName       = $_.displayName
            AccountEnabled    = $_.accountEnabled
            CreationDate      = [DateTime]$_.createdDateTime
        }))
    }

    if ($CloudAccounts.Count -gt ($AADUsersResponse.Count*(1/3))) {
        $Output.Result.Score       = 0
        $Output.Result.Data        = $CloudAccounts
        $Output.Result.Message     = '{0} cloud users where created in the past 6 months, more than 1/3 of the overall created accounts. {1}' -f $CloudAccounts.Count, $Output.ResultMessage
        $Output.Result.Remediation = $Output.Remediation
        $Output.Result.Status      = "Failed"
    } else {
        $Output.Result.Score       = 100
        $Output.Result.Data        = $CloudAccounts
        $Output.Result.Message     = '{0} cloud users where created in the past 6 months.' -f $CloudAccounts.Count
        $Output.Result.Remediation = "None"
        $Output.Result.Status      = "Pass"
    }
    $Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
}
catch {
    $_ | Write-Error
}

[PSCustomObject]$Output