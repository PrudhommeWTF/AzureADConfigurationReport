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
    ID                     = 'CR0031'
    ScriptName             = 'CR0031-GuestAccessRestrictions'
    Title                  = 'Guest Access permissions'
    Description            = 'Limit guest user permissions. Limiting guest access ensures that guest accounts do not have permission for certain directory tasks, such as enumerating users, groups or other directory resources, and cannot be assigned to administrative roles in your directory.<ol><li>Guest users have the same access as members (most inclusive)</li><li>Guest users have limited access to properties and memberships of directory objects (default value)</li><li>Guest user access is restricted to properties and memberships of their own directory objects (most restrictive)</li></ol><br><br>Becarefull! This Check Rule is currently using BETA endpoint in Microsoft Graph!'
    CategoryId             = 1
    Weight                 = 4
    LikelihoodOfCompromise = 'Guest may have access to User properties that you do not want to expose.'
    ResultMessage          = ''
    Remediation            = 'Navigate the following Azure AD Portal blade: Azure Active Directory > External Identities > External Collaboration Settings. Under "Guest user access", change the value of "Guest user access restrictions" to value "Guest user access is restricted to properties and memberships of their own directory objects"'
    Permissions            = @('Policy.Read.All')
    SecurityFrameworks = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('T1078.004 - Valid Accounts: Cloud Accounts','TA0001 - Initial Access', 'M1026 - Privileged Account Management')
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

switch ($AuthorizationPolicy.guestUserRoleId) {
    'a0b1b346-4d3e-4e8b-98f8-753987be4970' {
        $Output.Result.Score       = 0
        $Output.Result.Status      = 'Fail'
        $Output.Result.Message     = 'Same as member users - Guests have the same access to Azure AD resources as member users'
        $Output.Result.Remediation = $Output.Remediation
    }
    '10dae51f-b6af-4016-8d66-8c2a99b929b3' {
        $Output.Result.Score       = 50
        $Output.Result.Status      = 'Warning'
        $Output.Result.Message     = 'Limited access (default) - Guests can see membership of all non-hidden groups'
        $Output.Result.Remediation = $Output.Remediation
    }
    '2af84b1e-32c8-42b7-82bc-daa82404023b' {
        $Output.Result.Score   = 100
        $Output.Result.Status  = 'Pass'
        $Output.Result.Message = "Restricted access (new) - Guests can't see membership of any groups"
    }
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output