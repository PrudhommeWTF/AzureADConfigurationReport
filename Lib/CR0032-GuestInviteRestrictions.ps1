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
$Output = @{
    ID                     = 'CR0032'
    ScriptName             = 'CR0032-GuestInviteRestrictions'
    Title                  = 'User cannot invite Guest'
    Description            = 'Restrict invitations to users with specific administrative roles only.<br><br>Becarefull! This Check Rule is currently using BETA endpoint in Microsoft Graph!'
    CategoryId             = 1
    Weight                 = 3
    LikelihoodOfCompromise = 'Restricting invitations to users with specific administrator roles ensures that only authorized accounts have access to cloud resources. This helps to maintain "Need to Know" permissions and prevents inadvertent access to data.By default the setting Guest invite restrictions is set to Anyone in the organization can invite guest users including guests and non-admins. This would allow anyone within the organization to invite guests and non-admins to the tenant, posing a security risk.'
    ResultMessage          = 'Allow everyone in the organization, including guest users, to invite external users. The default setting for all cloud environments except US Government.'
    Remediation            = 'From the Azure Active Directory portal, navigate to the following blade: External Identities > External collaboration settings. In Guest invite settings, for Guest invite restrictions, check that "Only users assigned to specific admin roles can invite guest users" is selected'
    Permissions            = @('Policy.Read.All')
    SecurityFrameworks = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('T1078.004 - Valid Accounts: Cloud Accounts','TA0001 - Initial Access', 'M1026 - Privileged Account Management')
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
    ChangeLog              = @(
        [PSCustomObject]@{
            Version   = [Version]'1.0.0.0'
            ChangeLog = 'Initial version'
            Date      = '09/13/2022'
            Author    = "Thomas Prud'homme"
        }
        [PSCustomObject]@{
            Version   = [Version]'1.0.1.0'
            ChangeLog = @'
Added parameter ReturnScriptMetadata and logic enable main script to pull out $Output content with out running the entire script. In order to allow automated request of Graph API Permission when generating the Azure AD App Registration the first time.
Removed Severity
Added return of $Output in case of Graph API connection failure
'@
            Date      = '09/20/2022'
            Author    = "Thomas Prud'homme"
        }
        [PSCustomObject]@{
            Version   = [Version]'1.0.2.0'
            ChangeLog = 'Output initial hashtable re-ordering'
            Date      = '10/07/2022'
            Author    = "Thomas Prud'homme"
        }
    )
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
$GetAuthorizationPolicy = @{
    Method      = 'GET'
    Uri         = 'https://graph.microsoft.com/beta/policies/authorizationPolicy/authorizationPolicy'
    ContentType = 'application/json'
    Headers     = @{
        Authorization = "Bearer $GraphToken"
    }
}

try {
    $AuthorizationPolicy = Invoke-RestMethod @GetAuthorizationPolicy
}
catch {
    $_ | Write-Error
}

switch ($AuthorizationPolicy.allowInvitesFrom) {
    'none'	{
        $Output.Result.Score       = 100
        $Output.Result.Status      = 'Pass'
        $Output.Result.Message     = 'No evidence of exposure. Prevent everyone, including admins, from inviting external users. Default setting for US Government.'
        $Output.Result.Remediation = 'None'
    }
    'adminsAndGuestInviters' {
        $Output.Result.Score       = 100
        $Output.Result.Status      = 'Pass'
        $Output.Result.Message     = 'No evidence of exposure. Allow members of Global Administrators, User Administrators, and Guest Inviter roles to invite external users.'
        $Output.Result.Remediation = 'None'
        
    }
    'adminsGuestInvitersAndAllMembers' {
        $Output.Result.Score       = 100
        $Output.Result.Status      = 'Pass'
        $Output.Result.Message     = 'No evidence of exposure. Allow the above admin roles and all other User role members to invite external users.'
        $Output.Result.Remediation = 'None'
    }
    'everyone' {
        $Output.Result.Score       = 0
        $Output.Result.Status      = 'Fail'
        $Output.Result.Message     = $Output.ResultMessage
        $Output.Result.Remediation = $Output.Remediation
    }
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output