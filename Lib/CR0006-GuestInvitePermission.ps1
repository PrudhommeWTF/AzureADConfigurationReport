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
$Start = Get-Date
$Output = @{
    ID                     = 'CR0006'
    ScriptName             = 'CR0006-GuestInvitePermission'
    Title                  = 'Check for guests having permission to invite other guests'
    Description            = 'This indicator checks for guests that have permission to invite other guests.'
    CategoryId             = 1
    Weight                 = 5
    LikelihoodOfCompromise = 'Allowing guests to invite other guests means that invitations can take place outside of any entitlement management in place. For more info click <a href="https://docs.microsoft.com/en-us/azure/active-directory/governance/entitlement-management-external-users" target="_blank">here.</a>'
    ResultMessage          = 'Guests are allowed to send guest invitations.'
    Remediation            = 'Forbid guests from sending out invitations.'
    Permissions            = @('Policy.Read.All')
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
# Get Authorization Policy
try {
    $authorizationPolicyResult = Invoke-RestMethod -Method 'GET' -Uri 'https://graph.microsoft.com/v1.0/policies/authorizationPolicy' -ContentType 'application/json' -Headers @{
        Authorization = "Bearer $GraphToken"
    }
}
catch {
    Write-Error $_
    Continue
}

if ($authorizationPolicyResult.allowInvitesFrom -eq "everyone") {
    $Output.Result.Score = 0
    $Output.Result.Message = $Output.ResultMessage
    $Output.Result.Remediation = $Output.Remediation
    $Output.Result.Status = 'Fail'
}
else {
    $Output.Result.Score = 100
    $Output.Result.Message = 'No exposure evidence'
    $Output.Result.Remediation = "None"
    $Output.Result.Status = "Pass"
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output