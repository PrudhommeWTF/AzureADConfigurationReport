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
    ID                     = 'CR0033'
    ChangeLog              = @(
        [PSCustomObject]@{
            Version   = [Version]'1.0.0.0'
            ChangeLog = 'Initial version'
            Date      = [DateTime]'09/13/2022 21:30'
            Author    = "Thomas Prud'homme"
        }
    )
    CategoryId             = 4
    Title                  = 'Check user cannot create security groups'
    ScriptName             = 'CR0033-UserCanCreateSecurityGroup'
    Description            = @'
Restrict security group creation to administrators only

Becarefull! This Check Rule is currently using BETA endpoint in Microsoft Graph!
'@
    Weight                 = 7 #0 to 7. 0 being informational and 7 being critical
    Severity               = 'Critical' #Informational, Warning or Critical
    LikelihoodOfCompromise = 'When creating security groups is enabled, all users in the directory are allowed to create new security groups and add members to those groups. Unless a business requires this day-to-day delegation, security group creation should be restricted to administrators only.'
    ResultMessage          = 'Users can create security groups in Azure Active Directory.'
    Remediation            = 'From the Azure Active Directory portal, navigate to the following blade: Groups > General, under setting. Set "Users can create security groups in Azure portals, API or PowerShell" to "No"'
    Permissions            = @('Policy.Read.All')
    SecurityFrameworks = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('T1578','TA0005','M1018')
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

#region Main
$GetAuthorizationPolicy = @{
    Method      = 'GET'
    Uri         = 'https://graph.microsoft.com/beta/policies/authorizationPolicy/authorizationPolicy'
    ContentType = 'application/json'
    Headers     = @{
        Authorization = "Bearer $GraphToken"
    }
}

try {
    $AuthorizationPolicy = Invoke-RestMethod @GetAuthorizationPolicy
}
catch {
    $_ | Write-Error
}

if ($AuthorizationPolicy.defaultUserRolePermissions.allowedToCreateSecurityGroups -eq $false) {
    $Output.Result.Score       = 100
    $Output.Result.Status      = 'Pass'
    $Output.Result.Message     = 'No sign of exposure'
    $Output.Result.Remediation = 'None'
} else {
    $Output.Result.Score       = 0
    $Output.Result.Status      = 'Fail'
    $Output.Result.Message     = $Output.ResultMessage
    $Output.Result.Remediation = $Output.Remediation
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output