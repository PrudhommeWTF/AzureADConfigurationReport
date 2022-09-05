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
    ID                     = 'CR0023'
    Version                = [Version]'1.0.0.0'
    CategoryId             = 4
    Title                  = 'Check Domain Federation Settings'
    ScriptName             = 'CR0023-DomainFederationSettings'
    Description            = 'Attacker changed domain federation trust settings using Azure AD administrative permissions to configure the domain to accept authorization tokens signed by their own SAML signing certificate.'
    Weight                 = 0
    Severity               = 'Informational'
    LikelihoodOfCompromise = "Domain federation configuration being compromised can result in users beeing forwarded to attackers' IDP."
    ResultMessage          = ''
    Remediation            = 'Review and correct eventual glich or changes in the Federation Settings'
    Permissions            = @('Domain.Read.All')
    SecurityFrameworks = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Defense Evasion')
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

$BaseUri = 'https://graph.microsoft.com/v1.0'
$Rest101 = @{
    Method = 'GET'
    ContentType = 'application/json'
    Headers = @{
        Authorization = "Bearer $GraphToken"
    }
}

try {
    $DomainFederationConfig = (Invoke-RestMethod @Rest101 -Uri ('{0}/domains' -f $BaseUri)).Value | Where-Object -FilterScript {$_.authenticationType -ne 'Managed'} | ForEach-Object -Process {
        Invoke-RestMethod @Rest101 -Uri ('{0}/domains/{1}/federationConfiguration' -f $BaseUri, $_.id) | Select-Object -ExpandProperty Value
    }

    $Output.Result.Score       = 100
    $Output.Result.Status      = 'Pass'
    $Output.Result.Message     = 'No evidence of exposure'
    $Output.Result.Remediation = 'None'
    $Output.Result.Data        = $DomainFederationConfig
}
catch {
    $_ | Write-Error
}

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output