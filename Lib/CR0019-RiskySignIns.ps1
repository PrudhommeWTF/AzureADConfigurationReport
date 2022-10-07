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
    ID                     = 'CR0019'
    ScriptName             = 'CR0019-RiskySignIns'
    Title                  = 'Azure AD Risky Detections'
    Description            = 'Azure AD AI is capable of detecting sign-ins that may not be usual for company and users. It will then mark the sign-ins as "Risky" and depending on configuration may take actions to prevent sign-in.'
    CategoryId             = 5
    Weight                 = 4
    LikelihoodOfCompromise = ''
    ResultMessage          = 'Risky detection have been found in the tenant.'
    Remediation            = 'Ensure that Azure AD Conditional Access and Azure AD MFA is configured properly for all user accounts.'
    Permissions            = @('IdentityRiskEvent.Read.All')
    SecurityFrameworks = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Credential Access')
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
try {
    $RiskDetections = @{
        Method = 'GET'
        Uri = 'https://graph.microsoft.com/v1.0/identityProtection/riskDetections'
        ContentType = 'application/json'
        Headers = @{
            Authorization = "Bearer $GraphToken"
        }
    }
    $RiskySignins = Invoke-RestMethod @RiskDetections | Select-Object -ExpandProperty Value
}
catch {
    $RiskySignins = $null
}

if ($null -eq $RiskySignins) {
    $Output.Result.Score         = 100
    $Output.Result.Status        = 'Pass'
} else {
    $Output.Result.Score         = 0
    $Output.Result.Status        = 'Fail'
    $Output.Result.ResultMessage = $Output.ResultMessage
    $Output.Result.Remediation   = $Output.Remediation
    $Output.Result.Data          = $RiskySignins
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output