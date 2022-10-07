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
    ID                     = 'CR0025'
    ScriptName             = 'CR0025-TustedLocationIsUsed'
    Title                  = 'Trusted Locations are defined'
    Description            = 'Azure Active Directory Conditional Access allows an organization to configure Named locations and configure whether those locations are trusted or untrusted. These settings provide organizations the means to specify Geographical locations for use in conditional access policies, or define actual IP addresses and IP ranges and whether or not those IP addresses and/or ranges are trusted by the organization.'
    CategoryId             = 2
    Weight                 = 2 
    LikelihoodOfCompromise = 'Defining trusted source IP addresses or ranges helps organizations create and enforce Conditional Access Policies around those trusted or untrusted IP addresses and ranges. Users authenticating from trusted IP addresses and/or ranges may have less access restrictions or access requirements when compared to users that try to authenticate to Azure Active Directory from untrusted locations or untrusted source IP addresses/ranges.'
    ResultMessage          = 'Named Locations is not configured. It is recommanded to configure them and use them in Conditional Access Policies.'
    Remediation            = @'
Navigate to the following blade in the Azure AD Portal > Security > Named Locations. Configure the IP or Country locations following your business rules. Configure your Conditional Access Policies to use as inclusion or exclusion scope the configure Named Locations.
In general, Conditional Access policies may completely prevent users from authenticating to Azure Active Directory, and thorough testing is recommended. To avoid complete lockout, a 'Break Glass' account with full Global Administrator rights is recommended in the event all other administrators are locked out of authenticating to Azure Active Directory. This 'Break Glass' account should be excluded from Conditional Access Policies and should be configured with the longest pass phrase feasible. This account should only be used in the event of an emergency and complete administrator lockout.
'@
    Permissions            = @('Policy.Read.All')
    SecurityFrameworks = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('T1098.001 - Account Manipulation: Additional Cloud Credentials', 'TA0001 - Initial Access', 'M1030 - Network Segmentation')
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
$GetNamedLocations = @{
    Method = 'GET'
    Uri = 'https://graph.microsoft.com/v1.0/identity/conditionalAccess/namedLocations'
    ContentType = 'application/json'
    Headers = @{
        Authorization = "Bearer $GraphToken"
    }
}
try {
    $NamedLocations = Invoke-RestMethod @GetNamedLocations
}
catch {
    $_ | Write-Error
    Continue
}

if ($null -eq $NamedLocations) {
    $Output.Result.Score       = 0
    $Output.Result.Message     = $Output.ResultMessage
    $Output.Result.Remediation = $Output.Remediation
    $Output.Result.Status      = 'Fail'
} else {
    $Output.Result.Score       = 100
    $Output.Result.Data        = $NamedLocations
    $Output.Result.Message     = 'No exposure evidence'
    $Output.Result.Remediation = 'None'
    $Output.Result.Status      = 'Pass'
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output