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
    ID                     = 'CR0002'
    ChangeLog              = @(
        [PSCustomObject]@{
            Version   = [Version]'1.0.0.0'
            ChangeLog = 'Initial version'
            Date      = [DateTime]'09/13/2022 21:30'
            Author    = "Thomas Prud'homme"
        }
    )
    CategoryId             = 3
    Title                  = 'Users with privileges in AD and AAD'
    ScriptName             = 'CR0002-UsersWithPrivilegesInADAndAAD'
    Description            = 'This indicator checks for AAD privileged users that are also privileged in on-premise AD.'
    Weight                 = 7
    Severity               = 'Critical'
    LikelihoodOfCompromise = 'The compromise of an account that is privileged in both AD and AAD can result in both environments being compromised.'
    ResultMessage          = 'Found {COUNT} Privileged AAD users that are also privileged in AD'
    Remediation            = @'
Privileged in AD >  Do not sync to AAD.
Privileged in AAD > Make sure it is not a synced account, and not a continuous role member but rather an eligible role member (use PIM with eligible roles protected with MFA when elevating).
'@
    Permissions            = @('RoleManagement.Read.Directory', 'PrivilegedAccess.Read.AzureAD', 'Directory.Read.All', 'RoleEligibilitySchedule.Read.Directory')
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
$MatchesFound = 0
#endregion Init

#region Main
if ((Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain -eq $true) {
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
        $activeAdmins = @()
    
        foreach ($AadPrivilegedGUID in $AADRolesMapping.Keys) {
            $GetActiveAADAdministrators = @{
                Method = 'GET'
                Uri = "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments?`$filter=roleDefinitionId eq '$($AadPrivilegedGUID)'"
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
    
            while ($null -ne $AADAdministratorsResult.'@odata.nextLink') {
                $GetActiveAADAdministrators.Uri = $AADAdministratorsResult.'@odata.nextLink'
                $AADAdministratorsResult = Invoke-RestMethod @getActiveAADAdministrators
                $ActiveAdminsResponse += $AADAdministratorsResult.value
            }
    
            foreach ($admin in $ActiveAdminsResponse) {
                $GetUser = @{
                    Method = 'GET'
                    Uri = "https://graph.microsoft.com/v1.0/directoryObjects/$($admin.principalId)?`$select=onPremisesSecurityIdentifier,onPremisesImmutableId,id,userPrincipalName"
                    ContentType = 'application/json'
                    Headers = @{
                        Authorization = "Bearer $GraphToken"
                    }
                }
    
                try {
                    $User = Invoke-RestMethod @GetUser
                }
                catch {
                    $_ | Write-Error
                }
    
                if ($null -ne $User.onPremisesImmutableId) {
                    $ActiveAdmins += [PSCustomObject] @{
                        onPremisesSecurityIdentifier = $user.onPremisesSecurityIdentifier
                        onPremisesImmutableId = $user.onPremisesImmutableId
                        UPN = $user.userPrincipalName
                        ID = $user.id
                        RoleDefinitionID = $AADRolesMapping[$AadPrivilegedGUID]
                        State = "Active"
                    }
                }
    
            }
        }
    
        try {
            $GetPIMEligibleGlobalAdministrators = @{
                Method = 'GET'
                Uri = "https://graph.microsoft.com/beta/roleManagement/directory/roleEligibilityScheduleInstances?`$filter=(roleDefinitionId+eq+'62e90394-69f5-4237-9190-012177145e10'+or+roleDefinitionId+eq+'9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3'+or+roleDefinitionId+eq+'c4e39bd9-1100-46d3-8c65-fb160da0071f'+or+roleDefinitionId+eq+'b0f54661-2d74-4c50-afa3-1ec803f12efe'+or+roleDefinitionId+eq+'158c047a-c907-4556-b7ef-446551a6b5f7'+or++roleDefinitionId+eq+'b1be1c3e-b65d-4f19-8427-f6fa0d97feb9'+or+roleDefinitionId+eq+'29232cdf-9323-42fd-ade2-1d097af3e4de'+or+roleDefinitionId+eq+'729827e3-9c14-49f7-bb1b-9608f156bbb8'+or+roleDefinitionId+eq+'966707d0-3269-4727-9be2-8c3a10f19b9d'+or+roleDefinitionId+eq+'7be44c8a-adaf-4e2a-84d6-ab2649e08a13'+or+roleDefinitionId+eq+'194ae4cb-b126-40b2-bd5b-6091b380977d'+or+roleDefinitionId+eq+'f28a1f50-f6e7-4571-818b-6a12f2af6b6c'+or+roleDefinitionId+eq+'fe930be7-5e62-47db-91af-98c3a49a38b1'+or+roleDefinitionId+eq+'0526716b-113d-4c15-b2c8-68e3c22b9f80'+or+roleDefinitionId+eq+'be2f45a1-457d-42af-a067-6ec1fa63bc45')"
                ContentType = 'application/json'
                Headers = @{
                    Authorization = "Bearer $GraphToken"
                }
            }
    
            try {
                $PimResult = Invoke-RestMethod @GetPIMEligibleGlobalAdministrators
            }
            catch {
                $_ | Write-Error
            }
    
            $PimEligibleAdminsResponse = @($PimResult.value)
    
            While ($null -ne $PimResult.'@odata.nextLink') {
                $GetPIMEligibleGlobalAdministrators.Uri = $PimResult.'@odata.nextLink'
                $PimResult = Invoke-RestMethod @GetPIMEligibleGlobalAdministrators
                $PimEligibleAdminsResponse += $PimResult.value
            }
    
            $PimEligibleAdmins = $PimEligibleAdminsResponse |  ForEach-Object {
                $GetUser = @{
                    Method = 'GET'
                    Uri = "https://graph.microsoft.com/v1.0/directoryObjects/$($_.principalId)?`$select=onPremisesSecurityIdentifier,onPremisesImmutableId,id,userPrincipalName"
                    ContentType = 'application/json'
                    Headers = @{
                        Authorization = "Bearer $GraphToken"
                    }
                }
    
                $User = Invoke-RestMethod @GetUser
    
                if ($null -ne $User.onPremisesImmutableId ) {
                    [PSCustomObject] @{
                        onPremisesSecurityIdentifier = $user.onPremisesSecurityIdentifier
                        onPremisesImmutableId        = $user.onPremisesImmutableId
                        UPN                          = $user.userPrincipalName
                        ID                           = $user.id
                        RoleDefinitionID             = $AADRolesMapping[$_.roleDefinitionId]
                        State                        = 'Eligible'
                    }
                }
            }
            $AADAdmins = [array]$pimEligibleAdmins + [array]$activeAdmins
        }
        catch {
            $AADAdmins = $activeAdmins
        }
    
        $ADAdmins = ([ADSISearcher]'(&(objectCategory=person)(adminCount=1)(mS-DS-ConsistencyGuid=*))').FindAll() | ForEach-Object -Process {
            Write-Verbose "Processing result for $($_.Path)"
    
            #create an ordered hashtable with property names alphabetized
            $Properties = $_.Properties.PropertyNames | Sort-Object
            $ObjHash = [ordered]@{}
            foreach ($property in $Properties) {
                $value = $_.Properties.item($property)
                if ($value.count -eq 1) {
                    $value = $value[0]
                }
                $ObjHash.add($property,$value)
            }
            New-Object -TypeName PSObject -Property $ObjHash
        }
        if ($ADAdmins.Count -gt 0) {
            $MatchedAttribute = 'msdsConsistencyGuid'
        } else {
            $MatchedAttribute = 'SID'
            $ADAdmins = ([ADSISearcher]'(&(objectCategory=person)(adminCount=1))').FindAll() | ForEach-Object -Process {
                Write-Verbose "Processing result for $($_.Path)"
        
                #create an ordered hashtable with property names alphabetized
                $Properties = $_.Properties.PropertyNames | Sort-Object
                $ObjHash = [ordered]@{}
                foreach ($property in $Properties) {
                    $value = $_.Properties.item($property)
                    if ($value.count -eq 1) {
                        $value = $value[0]
                    }
                    $ObjHash.add($property,$value)
                }
                New-Object -TypeName PSObject -Property $ObjHash
            }
        }
    
        foreach ($admin in $ADAdmins) {
            $Filter = switch ($MatchedAttribute) {
                'msdsConsistencyGuid' {
                    { $_.onPremisesImmutableId -eq ([Convert]::ToBase64String($admin."ms-ds-consistencyguid")) }
                }
                'SID' {
                    { $_.onPremisesSecurityIdentifier -eq (New-Object System.Security.Principal.SecurityIdentifier($admin.objectsid,0)).Value }
                }
            }
            $OutputObjects += $AADAdmins | Where-Object -FilterScript $Filter | Foreach-Object {
                $MatchesFound++
                [PSCustomObject] @{
                    DistinguishedNameAD = $admin.DistinguishedName
                    AzureUPN            = $_.UPN
                    AzureID             = $_.ID
                    State               = $_.State
                    AADRole             = $_.RoleDefinitionID
                }
            }
        }
    
        if ($OutputObjects.Count -gt 0) {
            $Output.Result.Score       = 100 - (($matchesFound / $AADAdmins.Count) * 100)
            $Output.Result.Data        = $OutputObjects
            $Output.Result.Message     = $Output.ResultMessage.Replace('{COUNT}', $(@($OutputObjects | Sort-Object -Property AzureID -Unique).Count))
            $Output.Result.Remediation = $Output.Remediation
            $Output.Result.Status      = 'Fail'
        }
        else {
            $Output.Result.Score       = 100
            $Output.Result.Message     = "No evidence of exposure"
            $Output.Result.Remediation = "None"
            $Output.Result.Status      = "Pass"
        }
    }
    catch {
        $_ | Write-Error
    }
} else {
    $Output.Result.Data = 'Script started from a computer outside of Active Directory Domain Service.'
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output