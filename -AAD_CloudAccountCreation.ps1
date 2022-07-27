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

$Start  = Get-Date
$Output = @{
    ID                     = 0003
    Version                = [Version]'1.0.0.0'
    CategoryId             = 1
    ShortName              = 'CR0003'
    Name                   = 'Cloud only account creation'
    ScriptName             = 'AAD_CloudAccountCreation'
    Description            = 'This indicator will provide information on how frequently are created cloud only accounts'
    Weight                 = 7
    Severity               = 'Warning'
    LikelihoodOfCompromise = 'Cloud only accounts are often less managed than synchronized accounts.'
    ResultMessage          = 'Many cloud accounts are created recently.'
    Remediation            = 'Prefer usage of synchronizer acccounts or be sure to configure Azure MFA and Azure AD Conditional Access with the correct settings to secure them.'
    Permissions            = @('Directory.Read.All')
    SecurityFrameworks     = @(
        @{ Name = 'MITRE ATT&CK'; Tags = @('Initial Access', 'Persistence', 'Privilege Escalation') }
    )
    Result                 = @{
        Score         = 0
        Data          = ''
        Status        = ''
        ResultMessage = ''
        Remediation   = ''
        Timespan      = ''
    }
}

[Collections.ArrayList]$CloudAccounts = @()

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

    #Get All AAD Users
    $GetAADUsers = @{
        Method      = 'GET'
        Uri         = "https://graph.microsoft.com/v1.0/users?`$filter=userType eq 'Member'&`$select=id"
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

    #Filter all the synced user objects
    foreach ($entry in $AADUsersResponse) {
        $GetUserDetails = @{
            Method      = 'GET'
            Uri         = "https://graph.microsoft.com/v1.0/directoryObjects/$($entry.Id)?`$select=id,userPrincipalName,onPremisesSyncEnabled,accountEnabled,displayName,createdDateTime"
            ContentType = 'application/json'
            Headers     = @{
                Authorization = "Bearer $GraphToken"
            }
        }

        try {
            $UserDetailsResult = Invoke-RestMethod @GetUserDetails
        }
        catch {
            $_ | Write-Error
            Continue
        }

        if ($null -eq $UserDetailsResult.onPremisesSyncEnabled) {
            $null = $CloudAccounts.Add(([PSCustomObject][Ordered]@{
                ObjectId          = $UserDetailsResult.id
                UserPrincipalName = $UserDetailsResult.userPrincipalName
                DisplayName       = $UserDetailsResult.displayName
                AccountEnabled    = $UserDetailsResult.accountEnabled
                CreationDate      = [DateTime]$UserDetailsResult.createdDateTime
            }))
        }
    }

    if ($CloudAccounts.Count -gt ($AADUsersResponse.Count*(1/3))) {
        $Output.Result.Score       = 0
        $Output.Result.Data        = $CloudAccounts
        $Output.Result.Message     = $Output.ResultMessage
        $Output.Result.Remediation = $Output.Remediation
        $Output.Result.Status      = "Failed"
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