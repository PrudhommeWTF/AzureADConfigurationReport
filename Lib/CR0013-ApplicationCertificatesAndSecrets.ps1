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
    ID                     = 'CR0013'
    Version                = [Version]'1.0.0.0'
    CategoryId             = 2
    Title                  = 'Application Certificates & Secrets creation'
    ScriptName             = 'CR0013-ApplicationCertificatesAndSecrets'
    Description            = 'This indicator checks for newly created Certificates or Secrets on Azure AD Application.'
    Weight                 = 5
    Severity               = 'Warning'
    LikelihoodOfCompromise = 'Adversaries may add credentials for Applications in addition to existing legitimate credentials in Azure AD. These credentials include both x509 keys and passwords. With sufficient permissions, there are a variety of ways to add credentials including the Azure Portal, Azure command line interface, and Azure or Az PowerShell modules.'
    ResultMessage          = 'Application Registration may have acces from not trusted parties.'
    Remediation            = ''
    Permissions            = @('Application.Read.All', 'Directory.Read.All')
    SecurityFrameworks = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Persistence', 'Lateral Movement')
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
    #region Gather Azure AD Applications
    $GetApplications = @{
        Method      = 'GET'
        Uri         = 'https://graph.microsoft.com/v1.0/applications'
        ContentType = 'application/json'
        Headers     = @{
            Authorization = "Bearer $GraphToken"
        }
    }

    try {
        $ApplicationsResult = Invoke-RestMethod @GetApplications
    }
    catch {
        $_ | Write-Error
    }

    [Collections.ArrayList]$Applications = $ApplicationsResult.Value | Where-Object -FilterScript {$_.keyCredentials -ne $null -or $_.passwordCredentials -ne $null}

    while ($null -ne $ApplicationsResult.'@odata.nextLink') {
        $GetApplications.Uri = $ApplicationsResult.'@odata.nextLink'
        $ApplicationsResult = Invoke-RestMethod @GetApplications
        $Applications += $ApplicationsResult.Value | Where-Object -FilterScript {$_.keyCredentials -ne $null -or $_.passwordCredentials -ne $null}
    }
    #endregion Gather Azure AD Applications

    #check Certificate & Secrets creation timeline & warning
    $CertsAndCredsTable = foreach ($app in $Applications) {
        foreach ($cert in $app.keyCredentials) {
            [PSCustomObject][Ordered]@{
                AppId         = $app.id
                AppName       = $app.displayName
                Type          = 'Certificate'
                DisplayName   = $cert.displayName
                StartDateTime = ([DateTime]$cert.startDateTime).ToString()
                EndDateTime   = ([DateTime]$cert.endDateTime).ToString()
                ExpiringSoon  = $(if ([DateTime]$cert.endDateTime -gt $Start -and [DateTime]$cert.endDateTime -lt $Start.AddMonths(6)) {$true} else {$false})
                Expired       = $(if ([DateTime]$cert.endDateTime -lt $Start) {$true} else {$false})
            }
        }
        foreach ($secret in $app.passwordCredentials) {
            [PSCustomObject][Ordered]@{
                AppId         = $app.id
                AppName       = $app.displayName
                Type          = 'Secret'
                DisplayName   = $secret.displayName
                StartDateTime = ([DateTime]$secret.startDateTime).ToString()
                EndDateTime   = ([DateTime]$secret.endDateTime).ToString()
                ExpiringSoon  = $(if ([DateTime]$secret.endDateTime -gt $Start -and [DateTime]$secret.endDateTime -lt $Start.AddMonths(6)) {$true} else {$false})
                Expired       = $(if ([DateTime]$secret.endDateTime -lt $Start) {$true} else {$false})
            }
        }
    }

    if ($CertsAndCredsTable | Where-Object -FilterScript {$_.ExpiringSoon -eq $true}) {
        $Output.Result.Score       = [Math]::Round(100 - ((($CertsAndCredsTable | Where-Object -FilterScript {$_.ExpiringSoon -eq $true} | Measure-Object).Count / $Applications.Count) * 100),0)
        $Output.Result.Data        = $CertsAndCredsTable
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