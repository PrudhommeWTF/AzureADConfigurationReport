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
    ID                     = 'CR0001'
    ChangeLog              = @(
        [PSCustomObject]@{
            Version   = [Version]'1.0.0.0'
            ChangeLog = 'Initial version'
            Date      = '09/13/2022 21:30'
            Author    = "Thomas Prud'homme"
        }
        [PSCustomObject]@{
            Version   = [Version]'1.0.0.1'
            ChangeLog = @'
Added parameter ReturnScriptMetadata and logic enable main script to pull out $Output content with out running the entire script. In order to allow automated request of Graph API Permission when generating the Azure AD App Registration the first time.
Weight reviewed from 7 to 8
Removed Severity
Moved variable AADRolesMapping in Main region instead of Init
Added return of $Output in case of Graph API connection failure
'@
            Date      = '09/20/2022 23:30'
            Author    = "Thomas Prud'homme"
        }
    )
    CategoryId             = 3
    Title                  = 'Cloud accounts that have administrative roles'
    ScriptName             = 'CR0001-CloudUsersWithAdminRoles'
    Description            = 'This indicator checks for cloud users that have administrative roles in Azure AD.'
    Weight                 = 8
    LikelihoodOfCompromise = 'The compromise of a cloud account that admin roles in AAD can result in environment being compromised.'
    ResultMessage          = 'Found {COUNT} Privileged AAD cloud accounts.'
    Remediation            = 'Privileged in AAD > Make sure it is not a synced account, and not a continuous role member but rather an eligible role member (use PIM with eligible roles protected with MFA when elevating).'
    Detection              = @(
        'Monitor for suspicious account behavior across cloud services that share account.',
        'Monitor the activity of cloud accounts to detect abnormal or malicious behavior, such as accessing information outside of the normal function of the account or account usage at atypical hours.'
    )
    Permissions            = @('RoleManagement.Read.Directory', 'Directory.Read.All', 'RoleManagement.ReadWrite.Directory')
    SecurityFrameworks     = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Credential Access', 'Privilege Escalation')
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
[Collections.ArrayList]$AllAdmins = @()
[Collections.ArrayList]$CloudUserAsAdmin = @()
foreach ($RoleGuid in $AADRolesMapping.Keys) {
    $GetActiveAADAdministrators = @{
        Method = 'GET'
        Uri = 'https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments?$filter=roleDefinitionId eq {0}' -f "'$($RoleGuid)'"
        ContentType = 'application/json'
        Headers = @{
            Authorization = "Bearer $GraphToken"
        }
    }

    try {
        $AADAdministratorsResult = Invoke-RestMethod @GetActiveAADAdministrators
    }
    catch {
        $_ | Write-Error
        Continue
    }

    $ActiveAdminsResponse = @($AADAdministratorsResult.value)
    $AllAdmins += $AADAdministratorsResult.Value

    while ($null -ne $AADAdministratorsResult.'@odata.nextLink') {
        $GetActiveAADAdministrators.Uri = $AADAdministratorsResult.'@odata.nextLink'
        $AADAdministratorsResult = Invoke-RestMethod @GetActiveAADAdministrators
        $ActiveAdminsResponse += $AADAdministratorsResult.value
        $AllAdmins += $AADAdministratorsResult.Value
    }

    foreach ($admin in $ActiveAdminsResponse) {
        $GetObject = @{
            Method = 'GET'
            Uri = "https://graph.microsoft.com/v1.0/directoryObjects/$($admin.principalId)?`$select=id,userPrincipalName,onPremisesSyncEnabled,accountEnabled,displayName"
            ContentType = 'application/json'
            Headers = @{
                Authorization = "Bearer $GraphToken"
            }
        }

        try {
            $Object = Invoke-RestMethod @GetObject
        }
        catch {
            $_ | Write-Error
        }

        if ($null -eq $Object.onPremisesSyncEnabled) {
            $null = $CloudUserAsAdmin.Add(([PSCustomObject][Ordered]@{
                ObjectId          = $Object.id
                Type              = $Object.'@odata.type'.Split('.')[2]
                DisplayName       = $Object.displayName
                UserPrincipalName = $Object.userPrincipalName
                State             = $Object.accountEnabled
                Role              = $AADRolesMapping[$RoleGuid]
            }))
        }
    }
}

if ($CloudUserAsAdmin.count -gt 0) {
    $Output.Result.Score       = [Math]::Round(100 - (($CloudUserAsAdmin.Count / ($AllAdmins | Group-Object -Property principalId | Select-Object -ExpandProperty Name | Measure-Object).Count) * 100), 0)
    $Output.Result.Data        = $CloudUserAsAdmin
    $Output.Result.Message     = $Output.ResultMessage.Replace('{COUNT}', $CloudUserAsAdmin.Count)
    $Output.Result.Remediation = $Output.Remediation
    $Output.Result.Status      = 'Fail'
} else {
    $Output.Result.Score       = 100
    $Output.Result.Message     = "No evidence of exposure"
    $Output.Result.Remediation = "None"
    $Output.Result.Status      = "Pass"
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output