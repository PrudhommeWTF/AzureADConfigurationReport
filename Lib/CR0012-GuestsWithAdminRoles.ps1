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
    ID                     = 'CR0012'
    Version                = [Version]'1.0.0.0'
    CategoryId             = 3
    Title                  = 'Privileged group contains guest account'
    ScriptName             = 'CR0012-GuestsWithAdminRoles'
    Description            = 'This indicator checks whether any privileged roles have been assigned to guest accounts.'
    Weight                 = 7
    Severity               = 'Critical'
    LikelihoodOfCompromise = 'External attackers covet privileged accounts, as they provide a fast track to an organization''s most critical systems. Since guest accounts represent an external entity and do not undergo the same account security as users in your tenant, assigning privileged roles to them poses a heightened risk.'
    ResultMessage          = '{COUNT} privileged user(s) found as members of privileged groups.'
    Remediation            = 'Please review membership of privileged groups to determine if guest members have been authorized.'
    Permissions            = @('User.Read.All', 'RoleManagement.Read.Directory')
    SecurityFrameworks = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Privilege Escalation')
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
    $GetDirectoryRoles = @{
        Method = 'GET'
        Uri = 'https://graph.microsoft.com/v1.0/directoryRoles'
        ContentType = 'application/json'
        Headers = @{
            Authorization = "Bearer $GraphToken"
        }
    }

    try {
        $DirectoryRolesResult = Invoke-RestMethod @getDirectoryRoles
    }
    catch {
        $_ | Write-Error
        Continue
    }

    $DirectoryRoles = [System.Collections.ArrayList]@()
    $DirectoryRoles += $DirectoryRolesResult.value | Where-Object -FilterScript {$_.roleTemplateId -in $AADRolesMapping.keys}

    #The 'nextLink' property will keep being returned if there's another page
    While ($null -ne $DirectoryRolesResult.'@odata.nextLink') {
        $GetDirectoryRoles.Uri = $DirectoryRolesResult.'@odata.nextLink'
        $DirectoryRolesResult = Invoke-RestMethod @GetDirectoryRoles
        $DirectoryRoles += $directoryRolesResult.value | Where-Object -FilterScript {$_.roleTemplateId -in $AADRolesMapping.keys}
    }

    if ($DirectoryRoles) {
        #region Get all Azure AD Guest Accounts
        $GetGuestUsers = @{
            Method = 'GET'
            Uri = "https://graph.microsoft.com/v1.0/users?`$filter=userType eq 'Guest'"
            ContentType = 'application/json'
            Headers = @{
                Authorization = "Bearer $GraphToken"
            }
        }

        try {
            $GuestUsersResult = Invoke-RestMethod @GetGuestUsers
        }
        catch {
            $_ | Write-Error
            Continue
        }

        $GuestUsers = [System.Collections.ArrayList]@()
        $GuestUsers.AddRange($GuestUsersResult.value)

        #The 'nextLink' property will keep being returned if there's another page
        While ($null -ne $GuestUsersResult.'@odata.nextLink') {
            $GetGuestUsers.Uri = $GuestUsersResult.'@odata.nextLink'
            $GuestUsersResult = Invoke-RestMethod @GetGuestUsers
            $GuestUsers.AddRange($GuestUsersResult.value)
        }
        #endregion Get all Azure AD Guest Accounts

        #Loop through each role, get members, and check if they are a guest user
        foreach ($role in $DirectoryRoles) {
            $GetRoleMembers = @{
                Method = 'GET'
                Uri = "https://graph.microsoft.com/v1.0/directoryRoles/roleTemplateId=$($role.roleTemplateId)/members"
                ContentType = 'application/json'
                Headers = @{
                    Authorization = "Bearer $GraphToken"
                }
            }

            $RoleMembersResult = Invoke-RestMethod @GetRoleMembers

            $RoleMembers = [System.Collections.ArrayList]@()
            $RoleMembers.AddRange($RoleMembersResult.value)

            # The 'nextLink' property will keep being returned if there's another page
            While ($null -ne $RoleMembersResult.'@odata.nextLink') {
                $GetRoleMembers.Uri = $RoleMembersResult.'@odata.nextLink'
                $RoleMembersResult = Invoke-RestMethod @GetRoleMembers
                $RoleMembers.AddRange($RoleMembersResult.value)
            }

            foreach ($member in $RoleMembers) {
                if ($GuestUsers.UserPrincipalName -contains $member.UserPrincipalName) {
                    $null = $OutputObjects.Add(([PSCustomObject][Ordered] @{
                        UserPrincipalName = $member.userPrincipalName
                        RoleName = $role.displayName
                    }))
                }
            }
        }
    }

    if ($OutputObjects.count -gt 0) {
        $Output.Result.Score       = 0
        $Output.Result.Data        = $OutputObjects
        $Output.Result.Message     = $Output.ResultMessage.Replace('{COUNT}',$outputObjects.count)
        $Output.Result.Remediation = $Output.Remediation
        $Output.Result.Status      = 'Fail'
    } else {
        $Output.Result.Score       = 100
        $Output.Result.Message     = "No evidence of exposure"
        $Output.Result.Remediation = "None"
        $Output.Result.Status      = "Pass"
    }
}
catch {
    $_ | Write-Error
}

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output