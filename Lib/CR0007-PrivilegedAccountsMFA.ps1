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
    ID                     = 'CR0007'
    ScriptName             = 'CR0007-PrivilegedAccountsMFA'
    Title                  = 'MFA not configured for privileged accounts'
    Description            = 'This indicator checks that MFA (Multi-Factor Authentication) is enabled for users with administrative rights.'
    CategoryId             = 5
    Weight                 = 8
    LikelihoodOfCompromise = 'Accounts having privileged access are more valuable targets to attackers. A compromise of a privileged user represents a significant risk. As a result, these accounts require extra protections.'
    ResultMessage          = '{COUNT} privileged user(s) found without MFA configured.'
    Remediation            = 'It is recommended to configure MFA for privileged user(s).'
    Permissions            = @('RoleManagement.Read.Directory', 'Reports.Read.All')
    SecurityFrameworks     = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('T1098 - Account Manipulation', 'TA0003 - Persistence', 'M1032 - Multi-factor Authentication')
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
Reviewed Weight from 7 to 8
Removed Severity
Moved variable AADRolesMapping & OutputObjects to Main region instead of Init
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
$AADRolesMapping = @{
    "62e90394-69f5-4237-9190-012177145e10" = "Global administrator"
    "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3" = "Application administrator"
    "c4e39bd9-1100-46d3-8c65-fb160da0071f" = "Authentication administrator"
    "b0f54661-2d74-4c50-afa3-1ec803f12efe" = "Billing administrator"
    "158c047a-c907-4556-b7ef-446551a6b5f7" = "Cloud application administrator"
    "b1be1c3e-b65d-4f19-8427-f6fa0d97feb9" = "Conditional Access administrator"
    "29232cdf-9323-42fd-ade2-1d097af3e4de" = "Exchange administrator"
    "729827e3-9c14-49f7-bb1b-9608f156bbb8" = "Helpdesk administrator"
    "966707d0-3269-4727-9be2-8c3a10f19b9d" = "Password administrator"
    "7be44c8a-adaf-4e2a-84d6-ab2649e08a13" = "Privileged authentication administrator"
    "194ae4cb-b126-40b2-bd5b-6091b380977d" = "Security administrator"
    "f28a1f50-f6e7-4571-818b-6a12f2af6b6c" = "SharePoint administrator"
    "fe930be7-5e62-47db-91af-98c3a49a38b1" = "User administrator"
    "0526716b-113d-4c15-b2c8-68e3c22b9f80" = "Authentication Policy Administrator"
    "be2f45a1-457d-42af-a067-6ec1fa63bc45" = "External Identity Provider Administrator"
}
$OutputObjects = [System.Collections.ArrayList]@()
$GetDirectoryRoles = @{
    Method = 'GET'
    Uri = 'https://graph.microsoft.com/v1.0/directoryRoles'
    ContentType = 'application/json'
    Headers = @{
        Authorization = "Bearer $GraphToken"
    }
}
try {
    $DirectoryRolesResult = Invoke-RestMethod @GetDirectoryRoles
}
catch {
    $_ | Write-Error
    Continue
}

$DirectoryRoles = @()
$DirectoryRoles += $DirectoryRolesResult.value | Where-Object -FilterScript {$_.roleTemplateId -in $AADRolesMapping.keys}

#The 'nextLink' property will keep being returned if there's another page
While ($null -ne $DirectoryRolesResult.'@odata.nextLink') {
    $GetDirectoryRoles.Uri = $DirectoryRolesResult.'@odata.nextLink'
    $DirectoryRolesResult = Invoke-RestMethod @GetDirectoryRoles
    $DirectoryRoles += $DirectoryRolesResult.value | Where-Object -FilterScript {$_.roleTemplateId -in $AADRolesMapping.keys}
}

if ($DirectoryRoles) {
    # NOTE:  The "BETA" endpoint will need to be updated to v1.0 at some point
    $GetMFAReport = @{
        Method = 'GET'
        Uri = 'https://graph.microsoft.com/beta/reports/credentialUserRegistrationDetails'
        ContentType = 'application/json'
        Headers = @{
            Authorization = "Bearer $GraphToken"
        }
    }
    try {
        $CheckMFAResult = Invoke-RestMethod @GetMFAReport
    }
    catch {
        $_ | Write-Error
        Continue
    }

    $UserMFAResults = @()
    $UserMFAResults += $CheckMFAResult.value

    #The 'nextLink' property will keep being returned if there's another page
    While ($null -ne $CheckMFAResult.'@odata.nextLink') {
        $GetMFAReport.Uri = $CheckMFAResult.'@odata.nextLink'
        $CheckMFAResult = Invoke-RestMethod @GetMFAReport
        $UserMFAResults += $CheckMFAResult.value
    }

    #Loop through each role, get members, and check MFA registration status
    foreach ($directoryRole in $DirectoryRoles) {
        $GetRoleMember = @{
            Method = 'GET'
            Uri = "https://graph.microsoft.com/v1.0/directoryRoles/roleTemplateId=$($directoryRole.roleTemplateId)/members"
            ContentType = 'application/json'
            Headers = @{
                Authorization = "Bearer $GraphToken"
            }
        }

        $RoleMembersResult = Invoke-RestMethod @getRoleMember

        $RoleMembers = @()
        $RoleMembers += $RoleMembersResult.value

        # The 'nextLink' property will keep being returned if there's another page
        While ($null -ne $RoleMembersResult.'@odata.nextLink') {
            $getRoleMember.Uri = $RoleMembersResult.'@odata.nextLink'
            $RoleMembersResult = Invoke-RestMethod @GetRoleMember
            $RoleMembers += $RoleMembersResult.value
        }

        foreach ($member in $RoleMembers) {
            $ThisUserMFA = $userMFAResults | Where-Object -FilterScript {$_.userPrincipalName -eq $roleMember.userPrincipalName}

            If ($ThisUserMFA.isMfaRegistered -eq $false) {
                $ThisOutput = [PSCustomObject][Ordered] @{
                    UserName = $roleMember.userPrincipalName
                    MFARegistered = $thisUserMFA.isMfaRegistered
                }

                $null = $OutputObjects.Add($ThisOutput)
            }
        }
    }
}

$UniqueOutputObjects = @()
$UniqueOutputObjects += $OutputObjects | Sort-Object -Property UserName -Unique

if ($UniqueOutputObjects.count -eq 0) {
    $Output.Result.Score         = 0
    $Output.Result.Data          = $UniqueOutputObjects
    $Output.Result.Message       = $Output.ResultMessage.Replace('{COUNT}',$uniqueOutputObjects.count)
    $Output.Result.Remediation   = $Output.Remediation
    $Output.Result.Status        = 'Fail'
} else {
    $Output.Result.Score         = 100
    $Output.Result.Message       = 'No exposure evidence'
    $Output.Result.Remediation   = "None"
    $Output.Result.Status        = "Pass"
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output