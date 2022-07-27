<#
REFERENCE:
https://docs.microsoft.com/en-us/graph/api/authorizationpolicy-get?view=graph-rest-1.0

REQUIRED APP ROLE ACCESS
- READ AUTHORIZATION POLICY:  Policy.Read.All

Corresponding values for .defaultUserRolePermissions.permissionGrantPoliciesAssigned:

Do not allow user consent = NULL
Allow user consent for apps from verified publishers, for selected permissions = ManagePermissionGrantsForSelf.microsoft-user-default-low
Allow user consent for apps = ManagePermissionGrantsForSelf.microsoft-user-default-legacy
#>
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
    ID                     = 0010
    Version                = [Version]'1.0.0.0'
    CategoryId             = 2
    ShortName              = 'CR0010'
    Name                   = 'Unrestricted user consent allowed'
    ScriptName             = 'AAD_CheckUserConsent'
    Description            = 'This indicator checks if users are allowed to add applications from unverified publishers.'
    Weight                 = 5
    Severity               = 'Warning'
    LikelihoodOfCompromise = 'When users are allowed to consent to any 3rd party applications, there is considerable risk that an allowed app will take intrusive or risky actions.'
    ResultMessage          = 'Users are allowed to consent to risky 3rd party apps.'
    Remediation            = 'To protect the confidentiality of company data and improve security posture, it is recommended that users not have the ability to consent to all 3rd party apps. The best practice is to allow user consent only for applications that have been published by a verified publisher and have administrators approve all other consent requests via the admin consent workflow.'
    Permissions            = @('Policy.Read.All')
    SecurityFrameworks = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Persistence', 'Lateral Movement')
        }
    )
    Result                 = @{
        Score         = 0
        Status        = ''
        ResultMessage = ''
        Remediation   = ''
        Timespan      = ''
    }
}

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

    $GetAuthorizationPolicy = @{
        Method = 'GET'
        Uri = 'https://graph.microsoft.com/v1.0/policies/authorizationPolicy'
        ContentType = 'application/json'
        Headers = @{
            Authorization = "Bearer $GraphToken"
        }
    }

    try {
        $AuthorizationPolicyResult = Invoke-RestMethod @GetAuthorizationPolicy
    }
    catch {
        $_ | Write-Error
        Continue
    }

    $AuthorizationPolicy = $AuthorizationPolicyResult.defaultUserRolePermissions.permissionGrantPoliciesAssigned

    if ($AuthorizationPolicy -match "microsoft-user-default-legacy") {
        $Output.Result.Score       = 0
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