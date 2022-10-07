﻿[CmdletBinding(
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
    ID                     = 'CR0005'
    ScriptName             = 'CR0005-LegacyAuthentication'
    Title                  = 'Check if legacy authentication is allowed'
    Description            = 'This indicator checks whether legacy authentication is blocked, either via conditional access policies or security defaults.'
    CategoryId             = 6
    Weight                 = 5
    LikelihoodOfCompromise = 'Allowing legacy authentication increases the risk that an attacker will logon using previously compromised credentials. For more info click <a href="https://docs.microsoft.com/en-us/azure/active-directory/conditional-access/block-legacy-authentication" target="_blank">here.</a>'
    ResultMessage          = 'There are ZERO Conditional Access Policies configured to block Legacy Authentication.'
    Remediation            = 'To protect the authentication process, it is recommended to block legacy authentication either through conditional access policies or security defaults.'
    Permissions            = @('Policy.Read.All')
    SecurityFrameworks     = @(
        @{
            Name = 'MITRE ATT&CK'
            Tags = @('Credential Access')
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
$GetConditionalPolicies = @{
    Method = 'GET'
    Uri = 'https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies'
    ContentType = 'application/json'
    Headers = @{
        Authorization = "Bearer $GraphToken"
    }
}
try {
    $ConditionalAccessResult = Invoke-RestMethod @GetConditionalPolicies
}
catch {
    $_ | Write-Error
    Continue
}

$ConditionalAccessPolicies = [System.Collections.ArrayList]@()
$ConditionalAccessPolicies.AddRange($ConditionalAccessResult.value)

#The 'nextLink' property will keep being returned if there's another page
While ($null -ne $ConditionalAccessResult.'@odata.nextLink') {
    $GetConditionalPolicies.Uri = $ConditionalAccessResult.'@odata.nextLink'
    $ConditionalAccessResult = Invoke-RestMethod @GetConditionalPolicies
    $ConditionalAccessPolicies.AddRange($ConditionalAccessResult.value)
}

$LegacyAuthBlocked = $false

if ($ConditionalAccessPolicies | Where-Object -FilterScript {$_.grantControls.builtInControls -eq "block" -and $_.state -eq "enabled"}) {
    #One or more of the policies have a block...let's see if they are blocking the legacy clients
    foreach ($ConditionalAccessPolicy in $ConditionalAccessPolicies) {
        if ($ConditionalAccessPolicy.conditions.clientAppTypes -eq "exchangeActiveSync" -and $ConditionalAccessPolicy.conditions.clientAppTypes -eq "other") {
            #This policy blocks and DOES include the client types for legacy authentication is it enabled?
            if ($ConditionalAccessPolicy.state -eq "enabled") {
                $LegacyAuthBlocked = $true
            }
        }
    }
} else {
    #There are ZERO conditional access policies which are blocking access for legacy authentication
    #If "Security Defaults" are enabled, legacy authentication will be blocked as part of the defaults
    $SecurityDefaults = Invoke-RestMethod -Method 'GET' -Uri 'https://graph.microsoft.com/v1.0/policies/identitySecurityDefaultsEnforcementPolicy' -ContentType 'application/json' -Headers @{
        Authorization = "Bearer $GraphToken"
    }

    if ($securityDefaults.isEnabled -eq $true) {
        $LegacyAuthBlocked = $true
    }
}

if ($LegacyAuthBlocked -eq $false) {
    $Output.Result.Score       = 0
    $Output.Result.Message     = $Output.ResultMessage
    $Output.Result.Remediation = $Output.Remediation
    $Output.Result.Status      = 'Fail'
} else {
    $Output.Result.Score       = 100
    $Output.Result.Message     = 'No exposure evidence'
    $Output.Result.Remediation = "None"
    $Output.Result.Status      = "Pass"
}
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output