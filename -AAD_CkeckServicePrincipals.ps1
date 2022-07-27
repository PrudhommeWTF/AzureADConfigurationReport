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
    ID                     = 0014
    Version                = [Version]'1.0.0.0'
    CategoryId             = 2
    ShortName              = 'CR0014'
    Name                   = 'Service Principals'
    ScriptName             = 'AAD_CheckServicePrincipals'
    Description            = 'This indicator checks for newly created Certificates or Secrets on Azure AD Service Principals.'
    Weight                 = 5
    Severity               = 'Warning'
    LikelihoodOfCompromise = 'Adversaries may add credentials for Service Principals in addition to existing legitimate credentials in Azure AD. These credentials include both x509 keys and passwords. With sufficient permissions, there are a variety of ways to add credentials including the Azure Portal, Azure command line interface, and Azure or Az PowerShell modules.'
    ResultMessage          = 'Service Principals may have acces from not trusted parties.'
    Remediation            = ''
    Permissions            = @('Application.Read.All', 'Directory.Read.All')
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

    #region Gather Azure AD Service Principals
    $GetServicePrincipals = @{
        Method      = 'GET'
        Uri         = 'https://graph.microsoft.com/v1.0/servicePrincipals'
        ContentType = 'application/json'
        Headers     = @{
            Authorization = "Bearer $GraphToken"
        }
    }

    try {
        $ServicePrincipalsResult = Invoke-RestMethod @GetServicePrincipals
    }
    catch {
        $_ | Write-Error
    }

    [Collections.ArrayList]$ServicePrincipals = $ServicePrincipalsResult.Value

    while ($null -ne $ServicePrincipalsResult.'@odata.nextLink') {
        $GetServicePrincipals.Uri = $ServicePrincipalsResult.'@odata.nextLink'
        $ServicePrincipalsResult = Invoke-RestMethod @GetServicePrincipals
        $ServicePrincipals += $ServicePrincipalsResult.Value
    }
    #endregion Gather Azure AD Service Principals

    $Tests = @{
        Method      = 'GET'
        Uri         = 'https://graph.microsoft.com/v1.0/domains'
        ContentType = 'application/json'
        Headers     = @{
            Authorization = "Bearer $GraphToken"
        }
    }
    Invoke-RestMethod @Tests

    if ($AuthorizationPolicies.defaultUserRolePermissions.allowedToCreateApps -eq $true) {
        $Output.Result.Score       = 0
        $Output.Result.Message     = $Output.ResultMessage
        $Output.Result.Remediation = $Output.Remediation
        $Output.Result.Status      = 'Failed'

    } else {
        $Output.Result.Score       = 100
        $Output.Result.Message     = 'No evidence of exposure'
        $Output.Result.Remediation = 'None'
        $Output.Result.Status      = 'Pass'
    }
    $Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
}
catch {
    $_ | Write-Error
}
[PSCustomObject]$Output