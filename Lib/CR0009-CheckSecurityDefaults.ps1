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
    ID                     = 'CR0009'
    Version                = [Version]'1.0.0.0'
    CategoryId             = 1
    Title                  = 'Security defaults not enabled'
    ScriptName             = 'CR0009-CheckSecurityDefaults'
    Description            = 'This indicator checks whether security defaults are enabled when there are no conditional access policies configured.'
    Weight                 = 6
    Severity               = 'Warning'
    LikelihoodOfCompromise = 'As attackers constantly attempt to compromise cloud environments, it is important to maintain the highest possible security baseline for authentication. To protect the authentication process and privileged actions, security defaults are recommended for tenants that have no conditional access policies configured. Security defaults will require MFA, block legacy authentication, and require additional authentication when accessing the Azure portal, Azure Powershell, or the Azure CLI.'
    ResultMessage          = 'There are ZERO Conditional Access Policies enabled and Security Defaults are not configured.'
    Remediation            = 'If Conditional Access policies will not be used, enable Security Defaults.'
    Permissions            = @('Policy.Read.All')
    SecurityFrameworks     = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Initial Access', 'Credential Access')
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
    <#
        Security defaults and conditional access policies are mutually exclusive
        In this indicator, we check:
        Are there any enabled Conditional Access Policies?
        - If YES, do nothing
        - If NO, check to see if Security Defaults are enabled
        - If YES, indicator passes
        - If NO, indicator fails
    #>
    $GetConditionalPolicies = @{
        Method = 'GET'
        Uri = 'https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies'
        ContentType = 'application/json'
        Headers = @{
            Authorization = "Bearer $GraphToken"
        }
    }

    try {
        $ConditionalAccessResult = Invoke-RestMethod @GetConditionalPolicies
    }
    catch {
        $_ | Write-Error
        Continue
    }

    $ConditionalAccessPolicies = [System.Collections.ArrayList]@()
    $ConditionalAccessPolicies += $ConditionalAccessResult.value | Where-Object -FilterScript {$_.state -eq 'enabled'}

    #The 'nextLink' property will keep being returned if there's another page
    While ($null -ne $ConditionalAccessResult.'@odata.nextLink') {
        $GetConditionalPolicies.Uri = $ConditionalAccessResult.'@odata.nextLink'
        $ConditionalAccessResult = Invoke-RestMethod @GetConditionalPolicies
        $ConditionalAccessPolicies += $ConditionalAccessResult.value | Where-Object -FilterScript {$_.state -eq 'enabled'}
    }

    if ($ConditionalAccessPolicies.Count -eq 0) {
        $SecurityDefaultEnabled = $false

        # There are ZERO enabled conditional access policies
        # Check if Security Defaults are enabled
        $GetSecurityDefaults = @{
            Method = 'GET'
            Uri = 'https://graph.microsoft.com/v1.0/policies/identitySecurityDefaultsEnforcementPolicy'
            ContentType = 'application/json'
            Headers = @{
                Authorization = "Bearer $GraphToken"
            }
        }

        $SecurityDefaultsResult = Invoke-RestMethod @GetSecurityDefaults

        if ($SecurityDefaultsResult.isEnabled -eq $true) {
            $SecurityDefaultEnabled = $true
        }
    } else {
        $SecurityDefaultEnabled = $true
    }

    if ($SecurityDefaultEnabled -eq $false) {
        $Output.Result.Score       = 0
        $Output.Result.Message     = $Output.ResultMessage
        $Output.Result.Remediation = $Output.Remediation
        $Output.Result.Status      = 'Failed'
    } else {
        $Output.Result.Score       = 100
        $Output.Result.Message     = 'No evidence of exposure'
        $Output.Result.Remediation = 'None'
        $Output.Result.Status      = 'Pass'
        $Output.Result.Data        = $ConditionalAccessPolicies
    }
    $Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
}
catch {
    $_ | Write-Error
}
[PSCustomObject]$Output