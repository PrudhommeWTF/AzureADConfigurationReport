<#
REFERENCE:
https://posts.specterops.io/azure-privilege-escalation-via-azure-api-permissions-abuse-74aee1006f48

REQUIRED APP ROLE ACCESS
- List Applications:  Application.Read.All
- Get Service Principal:  Application.Read.All
#>
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

$Start  = Get-Date
$Output = @{
    ID                     = 0008
    Version                = [Version]'1.0.0.0'
    CategoryID             = 3
    ShortName              = 'CR0008'
    Name                   = 'Check for risky API permissions granted to application service principals'
    ScriptName             = 'AAD_CheckRiskyRoles'
    Description            = 'This indicator checks if one of the following risky application roles have been assigned for API permissions: RoleManagement.ReadWrite.Directory that can directly promote to Global Admin, and AppRoleAssignment.ReadWrite.All that can grant SELF above role, thus allowing promotion to Global Admin.'
    Weight                 = 5
    Severity               = 'Warning'
    LikelihoodOfCompromise = 'A malicious application administrator could use these permissions to grant administrative privileges to themself or another.'
    ResultMessage          = 'There are API permissions on application(s) which may be risky if not intended.'
    Remediation            = 'Please review API permissions for the application(s) listed to ensure only authorized rights are granted.'
    Permissions            = @('Application.Read.All')
    SecurityFrameworks     = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Privilege Escalation')
        }
    )
    Result                 = @{
        Score         = 0
        Status        = ''
        ResultMessage = ''
        Remediation   = ''
        Timespan      = ''
    }
}
$OutputObjects = @()

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

    $GetApplications = @{
        Method = 'GET'
        Uri = 'https://graph.microsoft.com/v1.0/applications'
        ContentType = 'application/json'
        Headers = @{
            Authorization = "Bearer $GraphToken"
        }
    }

    try {
        $ApplicationsResult = Invoke-RestMethod @GetApplications
    }
    catch {
        $_ | Write-Error
        Continue
    }

    $AADApplications = @($ApplicationsResult.value)

    # The 'nextLink' property will keep being returned if there's another page
    While ($null -ne $ApplicationsResult.'@odata.nextLink') {
        $GetApplications.Uri = $ApplicationsResult.'@odata.nextLink'
        $ApplicationsResult = Invoke-RestMethod @GetApplications
        $AADApplications += $ApplicationsResult.value
    }

    $RegisteredAppIDs = @()
    if ($AADApplications) {
        $RegisteredAppIDs += $AADApplications.appId
    }

    # Get IDs for each application
    $ServicePrincipalIDs = @()
    $ServicePrincipals = @()
    foreach ($AppID in $RegisteredAppIDs) {
        $GetAppIDs = @{
            Method = 'GET'
            Uri = "https://graph.microsoft.com/v1.0/servicePrincipals/?`$filter=(appid eq '$($AppID)')"
            ContentType = 'application/json'
            Headers = @{
                Authorization = "Bearer $GraphToken"
            }
        }

        $ServicePrincipals += (Invoke-RestMethod @GetAppIDs).Value
    }

    if ($ServicePrincipals) {
        $ServicePrincipalIDs += $ServicePrincipals.id
    }

    # Get app roles assigned to each Service Principal
    $ServicePrincipalAppRoles = [System.Collections.ArrayList]@()
    foreach ($servicePrincipalID in $ServicePrincipalIDs){
        $GetSPAppRoles = @{
            Method = 'GET'
            Uri = "https://graph.microsoft.com/v1.0/servicePrincipals/$($servicePrincipalID)/appRoleAssignments"
            ContentType = 'application/json'
            Headers = @{
                Authorization = "Bearer $GraphToken"
            }
        }

        $AppIDRoleResult = Invoke-RestMethod @GetSPAppRoles
        $ServicePrincipalAppRoles += $AppIDRoleResult.value
    }

    # Identify Service Principles with risky app roles
    # 9e3f62cf-ca93-4989-b6ce-bf83c28f9fe8 # RoleManagement.ReadWrite.Directory can directly promote to Global Admin
    # 06b708a9-e830-4db3-a914-8e69da51d44f # AppRoleAssignment.ReadWrite.All can grant SELF above role, thus allowing promotion to Global Admin

    foreach ($servicePrincipalAppRole in $ServicePrincipalAppRoles){
        if ($servicePrincipalAppRole.appRoleId -eq "9e3f62cf-ca93-4989-b6ce-bf83c28f9fe8" -Or $servicePrincipalAppRole.appRoleId -eq "06b708a9-e830-4db3-a914-8e69da51d44f") {
            if ($servicePrincipalAppRole.appRoleId -eq "9e3f62cf-ca93-4989-b6ce-bf83c28f9fe8") {
                $ThisAppRole = "RoleManagement.ReadWrite.Directory"
                $ThisWarning = "This role can directly modify Global Admin assignments"
            } else {
                $ThisAppRole = "AppRoleAssignment.ReadWrite.All"
                $ThisWarning = "This role can add itself to RoleManagmeent.ReadWrite.Directory which allows modification of Global Admin assignments"
            }

            $ThisOutput = [PSCustomObject][Ordered] @{
                ServicePrincipalDisplayName = $servicePrincipalAppRole.principalDisplayName
                RiskyAppRole = $ThisAppRole
                RiskWarning = $ThisWarning
            }
            $OutputObjects += $ThisOutput
        }
    }

    if ($OutputObjects.Count -gt 0) {
        $Output.Result.Score         = 0
        $Output.Result.Data          = $OutputObjects
        $Output.Result.Message = $Output.ResultMessage
        $Output.Result.Remediation   = $Output.Remediation
        $Output.Result.Status        = "Failed"
    }
    else {
        $Output.Result.Score         = 100
        $Output.Result.Message = "No evidence of exposure"
        $Output.Result.Remediation   = "None"
        $Output.Result.Status        = "Pass"
    }
    $Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
}
catch {
    $_ | Write-Error
}
[PSCustomObject]$Output