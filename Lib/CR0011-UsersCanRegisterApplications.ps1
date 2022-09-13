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
    ID                     = 'CR0011'
    ChangeLog              = @(
        [PSCustomObject]@{
            Version   = [Version]'1.0.0.0'
            ChangeLog = 'Initial version'
            Date      = [DateTime]'09/13/2022 21:30'
            Author    = "Thomas Prud'homme"
        }
    )
    CategoryId             = 2
    Title                  = 'Non-admin users can register custom applications'
    ScriptName             = 'CR0011-UsersCanRegisterApplications'
    Description            = 'This indicator checks if there exists an authorization policy that enables non-admin users to register custom applications'
    Weight                 = 7
    Severity               = 'Critical'
    LikelihoodOfCompromise = 'Allowing users to register custom-developed enterprise applications may be used by attackers to register nefarious applications. This can be leveraged, for example, to promote a user to give the attacker''s application permissions, or an admin to give it higher permissions only admins can grant.'
    ResultMessage          = 'Every user can register an application'
    Remediation            = 'It is recommended to disable this setting by going to AAD -> User settings -> App Registrations:Users can register applications -> and select "No" from the options.'
    Permissions            = @('Policy.Read.All')
    SecurityFrameworks     = @(
        @{ Name = 'MITRE ATT&CK'; Tags = @('Persistence', 'Privilege Escalation') }
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

#region Main
$GetAuthorizationPolicies = @{
    Method = 'GET'
    Uri = 'https://graph.microsoft.com/v1.0/policies/authorizationPolicy'
    ContentType = 'application/json'
    Headers = @{
        Authorization = "Bearer $GraphToken"
    }
}

try {
    $AuthorizationPolicies = Invoke-RestMethod @GetAuthorizationPolicies
}
catch {
    $_ | Write-Error
}

if ($AuthorizationPolicies.defaultUserRolePermissions.allowedToCreateApps -eq $true) {
    $Output.Result.Score       = 0
    $Output.Result.Message     = $Output.ResultMessage
    $Output.Result.Remediation = $Output.Remediation
    $Output.Result.Status      = 'Fail'

} else {
    $Output.Result.Score       = 100
    $Output.Result.Message     = "No evidence of exposure"
    $Output.Result.Remediation = "None"
    $Output.Result.Status      = "Pass"
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output