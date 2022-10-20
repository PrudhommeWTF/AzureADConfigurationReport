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
    ID                     = 'CR0004'
    ScriptName             = 'CR0004-UseOfAdministrativeUnits'
    Title                  = 'Administrative units are not being used'
    Description            = 'Check Rules to hightlight the usage of administrative units. Administrative units allows you to limit the scope of a authority and allow delegation on limited population.'
    CategoryId             = 3
    Weight                 = 4
    LikelihoodOfCompromise = 'In case of compromission an administrator account could have wide-ranging access across resources. When using Admninistrative Units you can limit the scope of specific delegated admin roles and ensure that compromise of admin credentials is limited and does not affect the all tenant.'
    ResultMessage          = 'There is no Administrative Units created.'
    Remediation            = 'Consider adding Administrative Units to limit delegation scope.'
    Permissions            = @('AdministrativeUnit.Read.All')
    SecurityFrameworks     = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Lateral Movement')
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
    $GetAdministrativeUnits = @{
        Method = 'GET'
        Uri = 'https://graph.microsoft.com/v1.0/directory/administrativeUnits'
        ContentType = 'application/json'
        Headers = @{
            Authorization = "Bearer $GraphToken"
        }
    }
    $AdministrativeUnitResult = Invoke-RestMethod @GetAdministrativeUnits
}
catch {
    $_ | Write-Error
    Continue
}

$AdministrativeUnits = [System.Collections.ArrayList]@()
$AdministrativeUnits.AddRange($AdministrativeUnitResult.value)

# The 'nextLink' property will keep being returned if there's another page
While ($null -ne $AdministrativeUnitResult.'@odata.nextLink') {
    $GetAdministrativeUnits.Uri = $AdministrativeUnitResult.'@odata.nextLink'
    $AdministrativeUnitResult = Invoke-RestMethod @GetAdministrativeUnits
    $AdministrativeUnits.AddRange($AdministrativeUnitResult.value)
}

if ($AdministrativeUnits.count -eq 0) {
    $Output.Result.Score       = 0
    $Output.Result.Message     = $Output.ResultMessage
    $Output.Result.Remediation = $Output.Remediation
    $Output.Result.Status      = 'Fail'
} else {
    $Output.Result.Score = 100
    $Output.Result.Data        = $AdministrativeUnits
    $Output.Result.Message     = 'No exposure evidence'
    $Output.Result.Remediation = "None"
    $Output.Result.Status      = "Pass"
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output