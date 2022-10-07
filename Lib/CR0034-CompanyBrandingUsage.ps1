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
    ID                     = 'CR0034'
    ScriptName             = 'CR0034-CompanyBrandingUsage'
    Title                  = 'Company branding is used'
    Description            = 'Check Rule to check and ensure that you are using Company Branding feature.'
    CategoryId             = 7
    Weight                 = 3 #0 to 10. 0 being informational and 10 being critical
    LikelihoodOfCompromise = 'Keeping the default Microsoft login page is not recommanded. With new attack vectors and credentials theft technics users may connect to portals that looks like the default login page of Microsoft Online. Using Company Branding to display your Company Logo and a Custom background in the Azure AD login page will give your users a clue when they are authenticating over Microsoft portals if they are being phished. '
    ResultMessage          = 'You are not using Company Branding.'
    Remediation            = 'Use Company Branding with your company logo and a custom background image linked to your company.'
    Permissions            = @('Organization.Read.All')
    SecurityFrameworks = @(
        @{
            Name = ''
            Tags = @()
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
$BaseUri = 'https://graph.microsoft.com/v1.0'
$Rest101 = @{
    Method = 'Get'
    ContentType = 'application/json'
    Headers = @{
        Authorization = "Bearer $GraphToken"
    }
}
$OrgInfos = (Invoke-RestMethod -Uri "$BaseUri/organization" @Rest101).Value
try {
    $null = Invoke-RestMethod -Uri "$BaseUri/organization/$($OrgInfos.id)/branding" @Rest101
    $Output.Result.Score       = 100
    $Output.Result.Message     = $Output.ResultMessage
    $Output.Result.Remediation = $Output.Remediation
    $Output.Result.Status      = 'Fail'
}
catch {
    $Output.Result.Score       = 0
    $Output.Result.Message     = 'No exposure evidence'
    $Output.Result.Remediation = 'None'
    $Output.Result.Status      = 'Pass'
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output