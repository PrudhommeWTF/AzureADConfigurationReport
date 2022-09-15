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
$Start = Get-Date
$MSGraphAPIUri = 'https://graph.microsoft.com/v1.0'
$Output = @{
    ID         = 'TI0001'
    Version    = [Version]'1.0.0.0'
    ScriptName = 'TI0001-TenantBasicInfo'
    Result     = @{
        Organization = ''
        OIDConfig    = ''
        Domains      = ''
        OrgBranding  = ''
        Timespan     = ''
        GraphAPI     = ''
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
$Rest101 = @{
    Method = 'Get'
    ContentType = 'application/json'
    Headers = @{
        Authorization = "Bearer $GraphToken"
    }
}
$Output.Result.Organization = (Invoke-RestMethod -Uri "$MSGraphAPIUri/organization" @Rest101).Value
$Output.Result.OIDConfig    = (Get-TenantOpenIDConfigInfo -TenantName $($Output.Result.Organization.verifiedDomains | Where-Object -FilterScript {$_.IsInitial -eq $true} | Select-Object -ExpandProperty Name))
$Output.Result.Branding     = Invoke-RestMethod -Uri "$MSGraphAPIUri/organization/$($Output.Result.Organization.id)/branding" @Rest101
$Output.Result.Timespan     = [String](New-TimeSpan -Start $Start -End (Get-Date))
#endregion Main

$Output.Result.Timespan = [String](New-TimeSpan -Start $Start -End (Get-Date))
[PSCustomObject]$Output