[CmdletBinding()]
Param(
    [String]$ConfigFileBaseName,
    [Switch]$OpenHtml
)

#region Functions
try {
    Import-Module "$PSScriptRoot\Lib\PSWriteHtml.psm1"
}
catch {
    throw $_
}

#Custom functions
Function Get-TenantOpenIDConfigInfo {
    Param(
        [Parameter(
            Mandatory = $true
        )]
        [String]$TenantName
    )
    Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/v2.0/.well-known/openid-configuration"
}
Function New-PSHtmlBootstrapTable {
    <#
        .DESCRIPTION
        Function to generate Html Table with Bootstrap Table library from PowerShell object (Array, Hashtable or PSCustomObject)

        .PARAMETER TableId
        Id for the Html Table

        .PARAMETER Data
        Input data to put in the Html Table

        .PARAMETER PropertiesMap
        Hashtable to map $Data properties to Table Header
        
        .PARAMETER Searchable
        Add search to the Html Table
        
        .PARAMETER Paged
        Add pagination to the Html Table
    #>
    Param(
        [Parameter(
            Mandatory = $true
        )]
        [String]$TableId,

        [Parameter(
            Mandatory = $true
        )]
        $Data,

        $PropertiesMap,

        [Switch]$Searchable,

        [Switch]$Paged,

        [Switch]$Sortable
    )
    if ($null -eq $PropertiesMap) {
        $PropertiesMap = $Data | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object -Process {
            @{
                field = $_
                title = $_
            }
        }
    }

    [Collections.Hashtable]$BootstrapTable = @{
        columns              = $PropertiesMap
        data                 = $Data
        showColums           = $true
        showColumnsSearch    = $true
        showColumnsToggleAll = $true
    }
    if ($Searchable) {
        $null = $BootstrapTable.Add('search', $true)
    }
    if ($Paged) {
        $null = $BootstrapTable.Add('pagination', $true)
        $null = $BootstrapTable.Add('showExtendedPagination', $true)
    }
    if ($Sortable) {
        $null = $BootstrapTable.Add('sortable', $true)
    }

    New-PSHtmlTable -class 'table table-striped' -id $TableId
    New-PSHtmlScript -Content "`$('#$TableId').bootstrapTable($($BootstrapTable | ConvertTo-Json -Compress))"
}
Function New-PSHtmlChartJS {
    <#
        .DESCRIPTION
        Generate Html and Javascript code to display charts using ChartJS library

        .PARAMETER ChartId
        Id to use for the Canvas Html tag entry

        .PARAMETER ChartType
        Type of chart to generate with ChartJS

        .PARAMETER ArrayTitleProperty
        In case of InputObject being an Array this parameter is use to specify colums

        .PARAMETER ArrayValueProperty
        In case of InputObject being an Array this parameter is use to specify values

        .PARAMETER InputObject
        Data to use as input for the chart
        .PARAMETER DatasetLabel
        .PARAMETER HideLegend
        .PARAMETER LineShowX
        .PARAMETER LineShowY
        .PARAMETER LineYMaxValue
    #>
    Param(
        $ChartId = 'myChart',
        [ValidateSet('line','doughnut','pie')]
        [String]$ChartType,

        [String]$ArrayTitleProperty = 'Name',
        [String]$ArrayValueProperty = 'Count',

        $InputObject,
        [String]$DatasetLabel,
        [Switch]$HideLegend,

        [Boolean]$LineShowX = $true,
        [Boolean]$LineShowY = $true,
        [Int]$LineYMaxValue = 100
    )
    $PresetColors = @('#F34F1C', '#7FBC00', '#FFBA01', '#01A6F0', '#747474')
    [Collections.Hashtable]$Dataset = @{}
    [Collections.Hashtable]$Options = @{
        plugins = [Collections.Hashtable]@{}
        scales  = [Collections.Hashtable]@{}
    }

    #region Data & Label format depending on InputObject type
    $Values = @()
    if ($InputObject -is [Array]) {
        $Labels = @()
        $InputObject | ForEach-Object -Process {
            $Labels += $_.$ArrayTitleProperty
            $Values += $_.$ArrayValueProperty
        }
    } elseif ($InputObject -is [Collections.ArrayList]) {
        $Labels = $InputObject.Keys
        $Labels | ForEach-Object -Process {
            $Values += $InputObject.$_
        }
    } else {
        $Labels = $InputObject | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
        foreach ($label in $Labels) {
            $Values += $InputObject.$label
        }
    }
    #endregion Data & Label format depending on InputObject type

    $null = $Dataset.Add('label', $DatasetLabel)
    $null = $Dataset.Add('data', $Values)

    if ($ChartType -eq 'line') {
        #region dataset options
        $Dataset.Add('fill', $false)
        $Dataset.Add('borderColor', '#0073aa')
        $Dataset.Add('borderWidth', 3)
        $Dataset.Add('tension', 0.1)
        #endregion dataset options

        #region x scale options
        [Collections.Hashtable]$xOptions = @{}
        if ($LineShowX -eq $false) {
            $xOptions.Add('display', $false)
        } else {
            $xOptions.Add('display', $true)
        }
        #endregion x scale options

        #region y scale options
        [Collections.Hashtable]$yOptions = @{}
        if ($LineShowY -eq $false) {
            $yOptions.Add('display', $false)
        } else {
            $yOptions.Add('display', $true)
        }
        $yOptions.Add('max', $LineYMaxValue)
        #endregion y scale options

        $Options.scales.Add('x', $xOptions)
        $Options.scales.Add('y', $yOptions)
    } elseif ($ChartType -eq 'pie' -or $ChartType -eq 'doughnut') {
        $Dataset.Add('backgroundColor', $PresetColors)
        $Dataset.Add('hoverOffset', 4)
    }

    if ($HideLegend) {
        $null = $Options.plugins.Add('legend', (@{
            display = $false
        }))
    }

    #Output
    New-PSHtmlDiv -Content {
        New-PSHtmlCanvas -id $ChartId 
        New-PSHtmlScript -Content "const $ChartId = new Chart(document.getElementById('$ChartId'), $(@{
            type    = $ChartType
            data    = @{
                labels   = $Labels
                datasets = @($Dataset)
            }
            options = $Options
        } | ConvertTo-Json -Depth 99 -Compress));"
    }
}
Function Invoke-ParallelRunSpace{
    <#
        .SYNOPSIS
            Allow to run some scriptblock in parallel

        .PARAMETER Parameter
            Specify parameters for the Scriptblock.

        .PARAMETER Scriptblock
            The Scriptblock(s) to run.

        .PARAMETER Throttle
            The throttling value is the number of parallel runspaces.

        .EXAMPLE
            Invoke-ParallelRunSpace -Scriptblock {Get-ADDCStatistics},{Get-ADOrgUnitsStatistics}
    #>
    [CmdletBinding()]
    Param(
        [Hashtable]$Parameter,
        [Scriptblock[]]$Scriptblock,
        [int]$Throttle = ([int]$env:NUMBER_OF_PROCESSORS+1),
        [Switch]$NotifyRunspaceEnded
    )

    #Initial sessionState, to be loaded with cmdlet for the runspaces
    $InitialSessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()

    #Search for function to add to runspaces
    foreach ($script in $Scriptblock) {
        [Management.Automation.PsParser]::Tokenize($script, [ref]$null) | Where-Object -FilterScript {$_.Type -eq 'Command'} | Select-Object -ExpandProperty Content | ForEach-Object -Process {
            Write-Verbose -Message "Adding $_ to the runspace..."
            if ($_ -notin $InitialSessionState.Commands.Name) {
                $FunctionToAdd = Get-Item -LiteralPath "function:$_"
                $InitialSessionState.Commands.Add((New-Object -TypeName System.Management.Automation.Runspaces.SessionStateFunctionEntry -ArgumentList $FunctionToAdd.Name,$FunctionToAdd.ScriptBlock))
            } else {
                Write-Verbose -Message "Function $_ already in InitialSessionState."
            }
        }
    }
    $RunspacePool = [runspacefactory]::CreateRunspacePool(1, $Throttle, $InitialSessionState, $Host)
    $RunspacePool.ApartmentState = 'MTA'
    $RunspacePool.Open()

    #Store the runspaces instances
    [Collections.ArrayList]$jobs = @()

    foreach ($script in $Scriptblock) {
        $RunSpaceName = [Management.Automation.PsParser]::Tokenize($script, [ref]$null) | Where-Object -FilterScript {$_.Type -eq 'Command'} | Select-Object -ExpandProperty Content | Select-Object -First 1
        Write-Verbose -Message "Creating a runspace for $RunSpaceName..."
        $PowerShell = [PowerShell]::Create()
        $PowerShell.RunspacePool = $RunspacePool

        $null = $PowerShell.AddScript($script)
        if($Parameter){
            $null = $PowerShell.AddParameters($Parameter)
        }
        Write-Verbose -Message "Starting a runspace for $RunSpaceName..."
        $Handle = $PowerShell.BeginInvoke()

        $null = $jobs.Add((New-Object -TypeName PSObject -Property @{
            PowerShell = $PowerShell
            Handle = $Handle
        }))
    }
    Write-Verbose -Message 'RunSpaces created, EndingInvoke...'
    $jobs | ForEach-Object -Process {
        $RunSpaceName = [Management.Automation.PsParser]::Tokenize($_.PowerShell.Commands.Commands.CommandText, [ref]$null) | Where-Object -FilterScript {$_.Type -eq 'Command'} | Select-Object -ExpandProperty Content | Select-Object -First 1
        Write-Verbose -Message "Ending a runspace for $RunSpaceName..."

        #Notify end of runspace
        if ($NotifyRunspaceEnded) {
            Write-Warning -Message "Runspace $RunSpaceName ended..."
        }

        New-Object -TypeName PSObject -Property @{
            Result    = $_.powershell.EndInvoke($_.handle)
            RunSpace  = $RunSpaceName
            HadErrors = $_.PowerShell.HadErrors
        }
        $_.PowerShell.Dispose()
    }
    $jobs.clear()
    $RunspacePool.Close()
    $RunspacePool.Dispose()
}
Function Set-ConfigurationFile {
    <#
        .DESCRIPTION
        Function to handle the tenant configuration file(s) and eventually generates Azure AD Application Registration with API Permissions in target tenant.
    #>

    $Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Title="$($global:ScriptTitle) - Tenant Configuration Tool" WindowStyle="ToolWindow" SizeToContent="WidthAndHeight">
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="200"/>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="Auto"/>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
      
        <TextBlock Grid.Column="0" Grid.Row="0" Margin="5">Configuration Name</TextBlock>
        <ComboBox Name="ConfigName" Grid.Column="1" Grid.Row="0" Height="22" Margin="5" IsEditable="True" IsTextSearchEnabled="True" IsTextSearchCaseSensitive="False"></ComboBox>
        <Button Name="BtnCreateAzureApp" Grid.Column="2" Grid.Row="0" Height="22" Margin="5">Create Azure AD Application</Button>
        <Button Name="BtnLoadConfig" Grid.Column="3" Grid.Row="0" Height="22" Margin="5">Load Existing Configuration</Button>

        <TextBlock Grid.Column="0" Grid.Row="1" Grid.ColumnSpan="4" Margin="5">Please Azure AD details:</TextBlock>

        <TextBlock Grid.Column="0" Grid.Row="2" Margin="5">Tenant ID</TextBlock>
        <TextBox Name="TenantId" Grid.Column="1" Grid.Row="2" Grid.ColumnSpan="3" Height="22" Margin="5"></TextBox>

        <TextBlock Grid.Column="0" Grid.Row="3" Margin="5">Application ID</TextBlock>
        <TextBox Name="AppId" Grid.Column="1" Grid.Row="3" Grid.ColumnSpan="3" Height="22" Margin="5"></TextBox>

        <TextBlock Grid.Column="0" Grid.Row="4" Margin="5">Application Secret</TextBlock>
        <TextBox Name="AppSecret" Grid.Column="1" Grid.Row="4" Grid.ColumnSpan="3" Height="22" Margin="5"></TextBox>

        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,10,5,0" Grid.Row="5" Grid.ColumnSpan="4">
            <Button Name="BtnOk" MinWidth="80" Height="22" Margin="0,0,5,5">OK</Button>
            <Button Name="BtnCancel" MinWidth="80" Height="22" Margin="5,0,0,5">Cancel</Button>
        </StackPanel>
    </Grid>
</Window>
"@

    #region Code Behind
    Function Convert-XAMLtoWindow {
        <#
            .DESCRIPTION
            Function to convert Xaml String to Window.

            .PARAMETER Xaml
            Xaml code to generate window
        #>
        Param(
            [Parameter(
                Mandatory = $true
            )]
            [String]$Xaml
        )
    
        Add-Type -AssemblyName PresentationFramework
        
        $Reader = [XML.XMLReader]::Create([IO.StringReader]$Xaml)
        $Result = [Windows.Markup.XAMLReader]::Load($Reader)
        $Reader.Close()
        $Reader = [XML.XMLReader]::Create([IO.StringReader]$Xaml)
        while ($Reader.Read()) {
            $Name = $Reader.GetAttribute('Name')
            if ($Name) {
                $Result | Add-Member NoteProperty -Name $Name -Value $Result.FindName($Name) -Force
            } else {
                $Name = $Reader.GetAttribute('x:Name')
            }
        }
        $Reader.Close()
        $Result
    }

    Function Show-WPFWindow {
        <#
            .DESCRIPTION
            Function to generate the Application Window from Window object.

            .PARAMETER Window
            Window object to generate WPF Window
        #>
        Param(
            [Parameter(
                Mandatory = $true
            )]
            [Windows.Window]$Window
        )
        
        $Result = $null
        $null = $Window.Dispatcher.InvokeAsync{
            $Result = $Window.ShowDialog()
            Set-Variable -Name result -Value $Result -Scope 1
        }.Wait()
        $Result
    }
    #endregion Code Behind

    #region Window action handlers
    $Window = Convert-XAMLtoWindow -XAML $Xaml

    #Loads all configs available in the Gui
    $Configs = Get-ChildItem -Path $PSScriptRoot -Filter '*.ini'
    if ($Configs) {
        $Window.ConfigName.ItemsSource = @($Configs.BaseName)
    }

    #Disable controls until a config is loaded or created
    $Window.AppId.IsEnabled = $Window.AppSecret.IsEnabled = $Window.TenantId.IsEnabled = $false

    #region buttons actions
    $window.BtnLoadConfig.add_Click({
        #Enable Controls
        $window.AppId.IsEnabled = $window.AppSecret.IsEnabled = $window.TenantId.IsEnabled = $true
        $window.BtnCreateAzureApp.IsEnabled = $false

        if (Test-Path -Path "$PSScriptRoot\$($window.ConfigName.Text).ini") {
            $Config = Import-Clixml -Path "$PSScriptRoot\$($window.ConfigName.Text).ini"
            $window.TenantId.Text  = $Config.TenantId
            $window.AppId.Text     = $Config.AppId
            $window.AppSecret.Text = $Config.Secret
        }
    })
    $window.BtnCreateAzureApp.add_Click({
        #Disable BtnLoadConfig during Azure AD App creation process
        $window.BtnLoadConfig.IsEnabled = $false

        #Load AzureAD module to handle the creation of AzureAD App Reg and setting API Permissions
        try {
            Import-Module -Name AzureAD
        }
        catch {
            Write-Warning -Message 'Failed loading AzureAD PowerShell module.'

            #Write encoutered error
            $_ | Write-Error

            #Close the window
            $window.DialogResult = $false
            
            #Exit script
            Exit
        }

        #Connecting AzureAD with user provided credentials
        try {
            $AzureADDetails = Connect-AzureAD
        }
        catch {
            Write-Warning -Message 'Failed connecting Azure AD with AzureAD module.'
            #Write encoutered error
            $_ | Write-Error

            #Close the window
            $window.DialogResult = $false
            
            #Exit script
            Exit
        }

        #Create the Azure AD Application
        $ReplyUrl = "https://portal.azure.com"
        try {
            $AzureADAppCreated = New-AzureADApplication  -DisplayName $global:ScriptTitle -Homepage $ReplyUrl -ReplyUrls $ReplyUrl
        }
        catch {
            Write-Warning -Message 'Failed creating Azure AD application with AzureAD module.'
            #Write encoutered error
            $_ | Write-Error

            #Close the window
            $window.DialogResult = $false
            
            #Exit script
            Exit
        }

        #List all required permissions in Check Rules scripts
        $ApplicationPermissions = @(
            'RoleManagement.Read.Directory',
            'PrivilegedAccess.Read.AzureAD',
            'Directory.Read.All',
            'RoleEligibilitySchedule.Read.Directory',
            'AdministrativeUnit.Read.All',
            'Policy.Read.All',
            'Reports.Read.All',
            'Application.Read.All',
            'IdentityRiskEvent.Read.All',
            'Domain.Read.All',
            'Organization.Read.All',
            'Domain.Read.All'
        )
        
        #Get Service Principal of Microsoft Graph Resource API 
        $GraphSP = Get-AzureADServicePrincipal -All $true | Where-Object {$_.DisplayName -eq 'Microsoft Graph' -and $_.AppId -eq '00000003-0000-0000-c000-000000000000'}

        #Initialize RequiredResourceAccess for Microsoft Graph Resource API 
        $RequiredGraphAccess = New-Object -TypeName Microsoft.Open.AzureAD.Model.RequiredResourceAccess
        $RequiredGraphAccess.ResourceAppId = $GraphSP.AppId
        $RequiredGraphAccess.ResourceAccess = New-Object -TypeName System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.ResourceAccess]

        #Add app permissions
        foreach ($permission in $ApplicationPermissions) {
            $RequiredPermission = $null
            #Get required app permission
            $RequiredPermission = $GraphSP.AppRoles | Where-Object -FilterScript {$_.Value -eq $permission}
            if ($RequiredPermission) {
                $ResourceAccess = New-Object Microsoft.Open.AzureAD.Model.ResourceAccess
                $ResourceAccess.Type = 'Role'
                $ResourceAccess.Id   = $RequiredPermission.Id    
                #Add required app permission
                $RequiredGraphAccess.ResourceAccess.Add($ResourceAccess)
            } else {
                Write-Host -Object "App permission $permission not found in the Graph Resource API" -ForegroundColor Red
            }
        }

        #Add required resource accesses
        $RequiredResourcesAccess = New-Object -TypeName System.Collections.Generic.List[Microsoft.Open.AzureAD.Model.RequiredResourceAccess]
        $RequiredResourcesAccess.Add($RequiredGraphAccess)
        
        #Set permissions in existing Azure AD App
        try {
            Set-AzureADApplication -ObjectId $AzureADAppCreated.ObjectId -RequiredResourceAccess $RequiredResourcesAccess
        }
        catch {
            Write-Warning -Message 'Failed adding permission to Azure AD application with AzureAD module.'
            #Write encoutered error
            $_ | Write-Error

            #Close the window
            $window.DialogResult = $false
            
            #Exit script
            Exit
        }

        #Generate a Secret to allow the tool to connect to the Azure AD App
        $SecretStartDate = Get-Date
        $AppSecret = New-AzureADApplicationPasswordCredential -ObjectId $AzureADAppCreated.ObjectId -CustomKeyIdentifier $global:ScriptTitle -StartDate $SecretStartDate -EndDate $($SecretStartDate.AddYears(3))

        #Enabling controls
        $window.AppId.IsEnabled = $window.AppSecret.IsEnabled = $window.TenantId.IsEnabled = $true

        #Set controls values with Azure AD App details
        $window.TenantId.Text  = $AzureADDetails.TenantId
        $window.AppId.Text     = $AzureADAppCreated.AppId
        $window.AppSecret.Text = $AppSecret.Value

        #Export configuration from Azure AD App to Ini file
        [PSCustomObject]@{
            TenantId = $TenantId
            AppId    = $AzureADAppCreated.AppId
            Secret   = $AppSecret.Value
        } | Export-Clixml -Path "$PSScriptRoot\$($window.ConfigName.Text).ini" -Encoding UTF8 -Depth 99 -Force

        #Output information on consent being required prior going forward with the script
        Write-Warning -Message 'Do not forget to grant Azure AD Application Registration permissions before going forward with the script.'
        Write-Warning -Message ('https://login.microsoftonline.com/{0}/adminconsent?client_id={1}' -f $AzureADDetails.TenantId, $AzureADAppCreated.AppId)        

        #Start to wait for application to be fully propagated in Azure AD with permissions
        $Minutes = 1
        $i = 0
        Write-Warning -Message "Start $Minutes minutes wait in order to ensure Azure AD App and API Permissions are propagated properly."
        do {
            Write-Host -Object '.' -NoNewline
            Start-Sleep -Seconds 1
            $i++
        }
        while ($i -eq ($Minutes*60))
        Start-Sleep -Seconds ($Minutes*60)
    })
    $window.BtnCancel.add_Click({
        $window.DialogResult = $false
    })
    $window.BtnOk.add_Click({
        $window.DialogResult = $true
    })
    #endregion Window action handlers

    $WPFResult = Show-WPFWindow -Window $window

    #region Process results
    if ($WPFResult -eq $true) {
        #Export configuration from WPF TextBox to Ini file
        [PSCustomObject]@{
            TenantId = $window.TenantId.Text
            AppId    = $window.AppId.Text
            Secret   = $window.AppSecret.Text
        } | Export-Clixml -Path "$PSScriptRoot\$($window.ConfigName.Text).ini" -Encoding UTF8 -Depth 99 -Force

        #Return the ConfigName selected in the WPF
        Write-Output -InputObject $window.ConfigName.Text
    } else {
        Write-Warning 'User aborted configuration management dialog.'
        Write-Output -InputObject $false
    }
    #endregion Process results
}
#endregion Functions

#region Init
$Start = Get-Date

#Title to be used all over the script (Host, WPF Gui or Html output)
$global:ScriptTitle = 'Azure AD Configuration Report'

Write-Output -InputObject ('{0} script started.' -f $global:ScriptTitle)

#Define Categories from MITRE ATT&CK to be displayed in Html and XML output files.
$Categories = @(
    @{
        Id          = 1
        Name        = 'Initial Access'
        Description = 'The adversary is trying to get into your network. Initial Access consists of techniques that use various entry vectors to gain their initial foothold within a network. Techniques used to gain a foothold include targeted spearphishing and exploiting weaknesses on public-facing web servers. Footholds gained through initial access may allow for continued access, like valid accounts and use of external remote services, or may be limited-use due to changing passwords.'
        Indicator   = $true
    }, @{
        Id          = 2
        Name        = 'Persistence'
        Description = 'The adversary is trying to maintain their foothold. Persistence consists of techniques that adversaries use to keep access to systems across restarts, changed credentials, and other interruptions that could cut off their access. Techniques used for persistence include any access, action, or configuration changes that let them maintain their foothold on systems, such as replacing or hijacking legitimate code or adding startup code.'
        Indicator   = $true
    }, @{
        Id          = 3
        Name        = 'Privilege Escalation'
        Description = 'The adversary is trying to gain higher-level permissions. Privilege Escalation consists of techniques that adversaries use to gain higher-level permissions on a system or network. Adversaries can often enter and explore a network with unprivileged access but require elevated permissions to follow through on their objectives. Common approaches are to take advantage of system weaknesses, misconfigurations, and vulnerabilities.'
        Indicator   = $true
    }, @{
        Id          = 4
        Name        = 'Defense Evasion'
        Description = "The adversary is trying to avoid being detected. Defense Evasion consists of techniques that adversaries use to avoid detection throughout their compromise. Techniques used for defense evasion include uninstalling/disabling security software or obfuscating/encrypting data and scripts. Adversaries also leverage and abuse trusted processes to hide and masquerade their malware. Other tactics' techniques are cross-listed here when those techniques include the added benefit of subverting defenses."
        Indicator   = $true
    }, @{
        Id          = 5
        Name        = 'Credential Access'
        Description = 'The adversary is trying to steal account names and passwords. Credential Access consists of techniques for stealing credentials like account names and passwords. Techniques used to get credentials include keylogging or credential dumping. Using legitimate credentials can give adversaries access to systems, make them harder to detect, and provide the opportunity to create more accounts to help achieve their goals.'
        Indicator   = $true
    }, @{
        Id          = 6
        Name        = 'Discovery'
        Description = "The adversary is trying to figure out your environment. Discovery consists of techniques an adversary may use to gain knowledge about the system and internal network. These techniques help adversaries observe the environment and orient themselves before deciding how to act. They also allow adversaries to explore what they can control and what's around their entry point in order to discover how it could benefit their current objective. Native operating system tools are often used toward this post-compromise information-gathering objective."
        Indicator   = $true
    }, @{
        Id          = 7
        Name        = 'Impact'
        Description = "The adversary is trying to manipulate, interrupt, or destroy your systems and data. Impact consists of techniques that adversaries use to disrupt availability or compromise integrity by manipulating business and operational processes. Techniques used for impact can include destroying or tampering with data. In some cases, business processes can look fine, but may have been altered to benefit the adversaries' goals. These techniques might be used by adversaries to follow through on their end goal or to provide cover for a confidentiality breach."
        Indicator   = $false
    }, @{
        Id          = 8
        Name        = 'Miscs'
        Description = 'Other indicators and checks that are not related to previous categories'
        Indicator   = $false
    }
)

#Define credits of Html Libraries being used in Html output
$HtmlCredits = @(
    @{
        Text = 'Bootstrap'
        Href = 'https://getbootstrap.com/'
    }, @{
        Text = 'Bootstrap Table'
        Href = 'https://bootstrap-table.com/'
    }, @{
        Text = 'ChartJS'
        Href = 'https://www.chartjs.org/'
    }
)

#Array to contain Indicators, used in outputs files
[Collections.ArrayList]$Indicators = @()

#region Select config file
if ([String]::IsNullOrWhiteSpace($ConfigFileBaseName)) {
    #List available configuration files from script folder
    $AvailableConfigs = Get-ChildItem -Path $PSScriptRoot -Filter '*.ini'

    #Prompt menu to choose configuration if any otherwise prompt Gui to create one
    if ($AvailableConfigs.Count -gt 0) {
        Write-Host "=============== $ScriptTitle Menu ==============="
        Write-Host ''
        $i = 0
        #Show a list of all available configuration BaseName
        foreach ($config in $AvailableConfigs) {
            Write-Host "$($i) - $($config.BaseName)"
            $i++
        }
        Write-Host ''
        Write-Host 'Press "M" to Manage configuration files.'
        Write-Host 'Press "Q" to Quit.'
        $SelectedConfig = Read-Host "Please make a selection"
        if ($SelectedConfig -eq 'Q') {
            #User requested to quit the script
            Exit
        } elseif ($SelectedConfig -eq 'M') {
            #User requested to manage configuration files, starting WPF Window
            $ConfigFileBaseName = Set-ConfigurationFile

            #Ensure user selected a tenant to audit
            if ($ConfigFileBaseName -eq $false) {
                #No tenant selected, exiting
                Exit
            } else {
                #Tenant selected, loading configuration file from script folder
                try {
                    $LoadedConfig = Import-Clixml -Path (Get-ChildItem -Path $PSScriptRoot -Filter "$ConfigFileBaseName.ini").FullName
                }
                catch {throw $_}
            }
        } else {
            #Load selected configuration from the in Host menu
            try {
                $LoadedConfig = Import-Clixml -Path $AvailableConfigs[$SelectedConfig].FullName
            }
            catch {throw $_}
        }
    } else {
        #Prompt Gui to handle tenant configuration
        $ConfigFileBaseName = Set-ConfigurationFile
        if ($ConfigFileBaseName -eq $false) {
            #No tenant selected, exiting
            Exit
        } else {
            #Tenant selected, loading configuration file from script folder
            try {
                $LoadedConfig = Import-Clixml -Path ($AvailableConfigs | Where-Object -FilterScript {$_.BaseName -eq $ConfigFileBaseName}).FullName
            }
            catch {throw $_}
        }
    }
} else {
    #A configration file BaseName was specified when calling script. Loading configuration file.
    Write-Output -InputObject "Loading specified config file: $ConfigFileBaseName"
    try {
        $LoadedConfig = Import-Clixml -Path ($AvailableConfigs | Where-Object -FilterScript {$_.BaseName -eq $ConfigFileBaseName}).FullName
        Write-Host -ForegroundColor 'Green' -Object "Loaded config for: $ConfigFileBaseName"
    }
    catch {
        Write-Host -ForegroundColor 'Red' -Object "Failed loading config for: $ConfigFileBaseName"
        throw $_
    }
}
#endregion Select config file

#Generate a Graph API Access Token with loaded configuration
Write-Output -InputObject "Trying to get a Graph API Access Token for tenant: $($LoadedConfig.TenantId)"
try {
    $GraphToken = Invoke-RestMethod -Method 'POST' -Uri "https://login.microsoftonline.com/$($LoadedConfig.TenantId)/oauth2/v2.0/token" -Body @{
        client_id     = $LoadedConfig.AppId
        client_secret = $LoadedConfig.Secret
        scope         = 'https://graph.microsoft.com/.default'
        grant_type    = 'client_credentials'
    } -ContentType 'application/x-www-form-urlencoded' -ErrorAction Stop | Select-Object -ExpandProperty 'access_token'
    Write-Host -ForegroundColor 'Green' -Object "Gathered a Graph API Access Token on tenant: $($LoadedConfig.TenantId)"
}
catch {
    Write-Host -ForegroundColor 'Red' -Object "Failed getting Graph API Access Token on tenant: $($LoadedConfig.TenantId)"
    throw $_
}
#endregion Init

#region Main
#region Gathering Azure AD Data
#Load as ScriptBlock all the Tenant Information and Check Rules scripts available in Lib folder
Write-Output -InputObject 'Loading Tenant Information and Check Rules scripts.'
$Scriptblocks = @(
    (Get-ChildItem -Path "$PSScriptRoot\lib" -Filter 'TI*-*.ps1')
    (Get-ChildItem -Path "$PSScriptRoot\lib" -Filter 'CR*-*.ps1')
) | ForEach-Object -Process {
    (Get-Command $_.FullName).ScriptBlock
}

#Use Runspaces to run all the previously loaded scriptblocks
Write-Output -InputObject "Start running scripts over target tenant: $($LoadedConfig.TenantId)"
try {
    $Outputs = Invoke-ParallelRunSpace -Scriptblock $Scriptblocks -Parameter @{
        GraphAPIAccessToken = $GraphToken
    } -ErrorAction Stop | Select-Object -ExpandProperty Result
    Write-Host -ForegroundColor 'Green' -Object 'Gathered scripts outputs'
}
catch {
    Write-Host -ForegroundColor 'Red' -Object 'Failed gathering scripts outputs'
    throw $_
}

#Create basic tenant information variables that may be require earlier than inside the Html content generation logics
$TenantInfoBasics = ($Outputs | Where-Object -FilterScript {$_.Id -eq 'TI0001'}).Result
$InitialDomain    = $TenantInfoBasics.Organization.verifiedDomains | Where-Object -FilterScript {$_.IsInitial -eq $true} | Select-Object -ExpandProperty Name

#Base Output file path
$BaseOutputFilePath = '{0}\Output\{1}-{2:yyyyMMdd_HHmm}' -f $PSScriptRoot, $InitialDomain, $Start

#Gathering reports indicator history (Xml files)
$IndicatorsHistory = Get-ChildItem -Path "$PSScriptRoot\Output\" -Filter "$InitialDomain-*.xml" | Sort-Object -Property CreationTime -Descending | Select-Object -First 5 | ForEach-Object -Process {
    $StrDate = $_.BaseName.Split('-')[1]
    $Data = Import-Clixml -Path $_.FullName
    $Date = Get-Date -Year $StrDate.Substring(0,4) -Month $StrDate.Substring(4,2) -Day $StrDate.Substring(6,2) -Hour $StrDate.Substring(9,2) -Minute $StrDate.Substring(11,2) -Second 00
    $Data.Indicators | ForEach-Object -Process {
        @{
            Name  = $_.Name
            Score = $_.Score
            Date  = $Date.ToString('MM/dd/yy')
        }
    }
}
#endregion Gathering Azure AD Data

#region Generating HTML and XML Output File
Write-Output -InputObject 'Start generating HTML content and file'
New-PSHtmlHtml -lang 'en' -Content {
    New-PSHtmlHead -Content {
        New-PSHtmlMeta -charset 'utf-8'
        New-PSHtmlTitle -Content $global:ScriptTitle
        New-PSHtmlLink -rel 'stylesheet' -href 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css'
        New-PSHtmlLink -rel 'stylesheet' -href 'https://unpkg.com/bootstrap-table@1.20.2/dist/bootstrap-table.min.css'
        New-PSHtmlLink -rel 'stylesheet' -href 'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css'
        New-PSHtmlScript -src 'https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js'
        New-PSHtmlScript -src 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js'
        New-PSHtmlScript -src 'https://unpkg.com/bootstrap-table@1.20.2/dist/bootstrap-table.min.js'
        New-PSHtmlScript -src 'https://cdn.jsdelivr.net/npm/chart.js'
        New-PSHtmlStyle -Content ".form-control-dark {color: #fff; background-color: rgba(255, 255, 255, .1);} .form-control-dark:focus {box-shadow: 0 0 0 3px rgba(255, 255, 255, .25);} .sidebar-overflow {height: 100%; overflow-x: auto;} .sidebar {position: fixed;top: 0;bottom: 0;left: 0;z-index: 100;padding: 48px 0 0;} .dropdown-toggle { outline: 0; } .accordion-body.bg-dark {color: white;} .btn-toggle,.btn-toggle-nochild {padding: .25rem .5rem; font-weight: 600;} .btn-toggle.btn-light::before {width: 1.25em; line-height: 0; content: url(`"data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='rgba%280,0,0%29' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 14l6-6-6-6'/%3e%3c/svg%3e`");} .btn-toggle.btn-dark::before {width: 1.25em; line-height: 0; content: url(`"data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='rgba%28255,255,255%29' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 14l6-6-6-6'/%3e%3c/svg%3e`");} .btn-toggle-nav a {padding: .1875rem .5rem; margin-top: .125rem; margin-left: 1.25rem;}"
        New-PSHtmlScript -lang 'javascript' -Content "function searchNavbar() { let input = document.getElementById('searchBar').value; input = input.toLowerCase(); let x = document.getElementsByClassName('navitem'); for (i = 0; i < x.length; i++) { if (!x[i].innerHTML.toLowerCase().includes(input)) { x[i].style.display=`"none`" } else { x[i].style=`"`" } } }"
    }
    New-PSHtmlBody -Content {
        New-PSHtmlHeader -class 'navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 border-bottom' -Content {
            New-PSHtmldiv -class 'container-fluid' -Content {
                New-PSHtmlA -class 'navbar-brand' -href '#' -Content $global:ScriptTitle
                New-PSHtmlInput -class 'form-control form-control-dark w-100' -id 'searchBar' -onkeyup 'searchNavbar()' -type 'text' -OtherAttributes @{
                    'placeholder' = 'Search'
                    'aria-label'  = 'Search'
                }
                New-PSHtmlDiv -class 'navbar-nav ps-2' -style 'flex-direction: row;' -Content {
                    New-PSHtmlNav -class 'nav-item' -Content {
                        New-PSHtmlDiv -class "form-check form-switch pt-2" -Content {
                            New-PSHtmlLabel -class "form-check-label" -for "lightSwitch" -Content {
                                New-PSHtmlSvg -OtherAttributes @{
                                    xmlns   = 'http://www.w3.org/2000/svg'
                                    width   = 25
                                    height  = 25
                                    fill    = 'currentColor'
                                    class   = 'bi bi-brightness-high'
                                    viewBox = '0 0 16 16'
                                } -Content {
                                    '<path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z" />'
                                }
                            }
                            New-PSHtmlInput -class 'form-check-input' -type 'checkbox' -id 'lightSwitch'
                        }
                    }
                    New-PSHtmlDiv -class 'nav-item' -Content {
                        New-PSHtmla -class 'nav-link px-3' -href '#' -OtherAttributes @{
                            'data-bs-toggle' = 'offcanvas'
                            'data-bs-target' = '#offcanvasAbout'
                            'aria-controls'  = 'offcanvasAbout'
                        } -Content 'About'
                    }
                }
            }
            New-PSHtmlDiv -class 'offcanvas offcanvas-end bg-light' -id "offcanvasAbout" -OtherAttributes @{
                tabindex = '-1'
                'aria-labelledby' = "offcanvasAboutDetailsLabel"
            } -style 'width: 50vw;' -Content {
                New-PSHtmlDiv -class 'offcanvas-header' -Content {
                    New-PSHtmlh5 -class 'offcanvas-title' -id "offcanvasAboutDetailsLabel" -Content "Script Information"
                    New-PSHtmlbutton -type 'button' -class 'btn-close' -OtherAttributes @{
                        'data-bs-dismiss' = 'offcanvas'
                        'aria-label' = 'Close'
                    }
                }
                New-PSHtmlDiv -class 'offcanvas-body' -Content {
                    New-PSHtmlnav -Content {
                        New-PSHtmldiv -class 'nav nav-tabs' -id 'nav-tab' -OtherAttributes @{role='tablist'} -Content {
                            New-PSHtmlbutton -class 'nav-link active' -id 'Timespan-tab' -OtherAttributes @{
                                'data-bs-toggle' = 'tab'
                                'data-bs-target' = '#Timespan'
                                'type'           = 'button'
                                'role'           = 'tab'
                                'aria-controls'  = 'Timespan'
                                'aria-selected'  = $true
                            } -Content 'Script Execution Timespan'
                            New-PSHtmlbutton -class 'nav-link' -id 'credit-tab' -OtherAttributes @{
                                'data-bs-toggle' = 'tab'
                                'data-bs-target' = '#credit'
                                'type'           = 'button'
                                'role'           = 'tab'
                                'aria-controls'  = 'credit'
                                'aria-selected'  = $false
                            } -Content 'Credit'
                        }
                    }
                    New-PSHtmldiv -class 'tab-content mt-2' -Content {
                        New-PSHtmldiv -class 'tab-pane fade show active' -id 'Timespan' -OtherAttributes @{
                            'role' = 'tabpanel'
                            'aria-labelledby' = 'Timespan-tab'
                            'tabindex' = 0
                        } -Content {
                            New-PSHtmlBootstrapTable -TableId 'ScriptTimespan' -Data ($Outputs | Select-Object -Property Title,ScriptName,@{n='Execution Time';e={$_.Result.Timespan}})
                        }
                        New-PSHtmldiv -class 'tab-pane fade' -id 'credit' -OtherAttributes @{
                            'role' = 'tabpanel'
                            'aria-labelledby' = 'credit-tab'
                            'tabindex' = 0
                        } -Content {
                            New-PSHtmlP -Content 'Open source components:'
                            New-PSHtmlUl -Content {
                                foreach ($entry in $HtmlCredits) {
                                    New-PSHtmlLi -Content {
                                        New-PShtmlA -Href $entry.Href -Content $entry.Text -target '_blank'
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        New-PSHtmlDiv -class 'row container-fluid' -style 'margin-top: 15px;' -Content {
            New-PSHtmlNav -class 'col-2 bg-light sidebar border-end' -Content {
                New-PSHtmlDiv -class 'position-sticky sidebar-sticky sidebar-overflow' -Content {
                    New-PSHtmlUl -class 'list-unstyled' -id 'contentTable' -Content {
                        New-PSHtmlLi -class 'mb-1 navitem' -Content {
                            New-PSHtmlA -class 'btn btn-light btn-toggle-nochild' -href '#TenantInfoCard' -Content 'Tenant Informations'
                            
                        }
                        New-PSHtmlLi -class 'mb-1 navitem' -Content {
                            New-PSHtmlA -class 'btn btn-light btn-toggle-nochild' -href '#AzureADIndicatorCard' -Content 'Azure AD Indicators'
                            
                        }
                        foreach ($category in $Categories) {
                            New-PSHtmlLi -class 'mb-1' -Content {
                                New-PSHtmlA -class 'btn btn-light btn-toggle navitem' -href "#Card$($category.Id)" -OtherAttributes @{
                                    'data-bs-toggle' = 'collapse'
                                    'data-bs-target' = "#sidebar$($category.Id)-collapse"
                                    'aria-expanded'  = $true
                                } -Content $category.Name
                                New-PSHtmlDiv -class 'collapse show' -id "sidebar$($category.Id)-collapse" -Content {
                                    New-PSHtmlUl -class 'btn-toggle-nav list-unstyled fw-normal pb-1 small' -Content {
                                        foreach ($item in ($Outputs | Where-Object -FilterScript {$_.CategoryId -eq $category.Id})) {
                                            New-PSHtmlLi -class 'navitem' -Content {
                                                New-PSHtmlA -href "#$($item.Id)" -class 'btn btn-light' -Content $item.Title -style 'text-align: initial'
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            New-PSHtmlMain -class 'col-10 ms-sm-auto px-md-4' -Content {
                #Tenant Information Html Card
                New-PSHtmlDiv -class 'card bg-light mb-2' -id 'TenantInfoCard' -Content {
                    $TenantInfosCardId = 'TenantInformations'
                    New-PSHtmlDiv -class 'card-header collapsed' -OtherAttributes @{
                        'data-bs-toggle' = 'collapse'
                        'data-bs-target' = "#$TenantInfosCardId"
                        'aria-expanded'  = $false
                        'aria-controls'  = $TenantInfosCardId
                    } -Content {
                        New-PSHtmlH5 -Content 'Tenant Informations and Statistics'
                    }
                    New-PSHtmlDiv -class 'card-body collapse' -id $TenantInfosCardId -Content {
                        New-PSHtmlP -Content 'This section shows the main technical characteristics of the tenant.'
                        New-PSHtmlTable -class 'table table-striped' -Content {
                            New-PSHtmlThead -Content {
                                New-PSHtmlTr -Content {
                                    New-PSHtmlTh -Content 'Tenant Name'
                                    New-PSHtmlTh -Content 'Tenant Id'
                                    New-PSHtmlTh -Content 'Creation date'
                                    New-PSHtmlTh -Content 'Region'
                                }
                            }
                            New-PSHtmlTbody -Content {
                                New-PSHtmlTr -Content {
                                    New-PSHtmlTd -Content $InitialDomain
                                    New-PSHtmlTd -Content $TenantInfoBasics.Organization.id
                                    New-PSHtmlTd -Content $([DateTime]$TenantInfoBasics.Organization.createdDatetime)
                                    New-PSHtmlTd -Content $TenantInfoBasics.OIDConfig.tenant_region_scope
                                }
                            }
                        }
                        New-PSHtmldiv -class 'accordion' -id 'tenantInfoAccordion' -Content {
                            #Tenant Business Card
                            New-PSHtmldiv -class 'accordion-item' -Content {
                                New-PSHtmlH2 -class 'accordion-header' -id 'businessCardLabel' -Content {
                                    New-PSHtmlbutton -class 'accordion-button' -OtherAttributes @{
                                        'type'           = 'button'
                                        'data-bs-toggle' = 'collapse'
                                        'data-bs-target' = '#businessCardCollapse'
                                        'aria-controls'  = 'businessCardCollapse'
                                    } -Content 'Tenant Business Card'
                                }
                                New-PSHtmlDiv -id 'businessCardCollapse' -class 'accordion-collapse collapse show' -OtherAttributes @{
                                    'aria-labelledby' = 'businessCardLabel'
                                    'data-bs-parent'  = '#tenantInfoAccordion'
                                } -Content {
                                    New-PSHtmlDiv -class 'row justify-content-center py-4' -Content {
                                        New-PSHtmlDiv -class 'col-8' -content {
                                            New-PSHtmlDiv -class 'card bg-light' -Content {
                                                New-PSHtmlDiv -class 'card-body' -Content {
                                                    New-PSHtmlDiv -class 'row' -Content {
                                                        New-PSHtmlDiv -class 'col-8' -Content {
                                                            New-PSHtmlH3 -Content $TenantInfoBasics.Organization.displayName
                                                            New-PSHtmlTable -Content {
                                                                New-PSHtmlTr -Content {
                                                                    New-PSHtmlTh -Content 'Street'
                                                                    New-PSHtmlTd -Content $TenantInfoBasics.Organization.street
                                                                }
                                                                New-PSHtmlTr -Content {
                                                                    New-PSHtmlTh -Content 'City'
                                                                    New-PSHtmlTd -Content $TenantInfoBasics.Organization.city
                                                                }
                                                                New-PSHtmlTr -Content {
                                                                    New-PSHtmlTh -Content 'Postal Code'
                                                                    New-PSHtmlTd -Content $TenantInfoBasics.Organization.postalCode
                                                                }
                                                                New-PSHtmlTr -Content {
                                                                    New-PSHtmlTh -Content 'State'
                                                                    New-PSHtmlTd -Content $TenantInfoBasics.Organization.state
                                                                }
                                                                New-PSHtmlTr -Content {
                                                                    New-PSHtmlTh -Content 'Phone'
                                                                    New-PSHtmlTd -Content $TenantInfoBasics.Organization.businessPhones
                                                                }
                                                            }
                                                        }
                                                        New-PSHtmlDiv -class 'col-4' -Content {
                                                            if ($TenantInfoBasics.Branding.bannerLogoRelativeUrl) {
                                                                New-PSHtmlImg -src ('https://{0}/{1}' -f $TenantInfoBasics.Branding.cdnList[0], $TenantInfoBasics.Branding.bannerLogoRelativeUrl)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            #Notification Email
                            New-PSHtmldiv -class 'accordion-item' -Content {
                                New-PSHtmlh2 -class 'accordion-header' -id 'notificationEmailLabel' -Content {
                                    New-PSHtmlbutton -class 'accordion-button' -OtherAttributes @{
                                        'type' = 'button'
                                        'data-bs-toggle' = 'collapse'
                                        'data-bs-target' = '#notificationEmailCollapse'
                                        'aria-controls'  = 'notificationEmailCollapse'
                                    } -Content 'Technical Notification Email'
                                }
                                New-PSHtmldiv -id 'notificationEmailCollapse' -class 'accordion-collapse collapse show' -OtherAttribute @{
                                    'aria-labelledby' = 'notificationEmailLabel'
                                    'data-bs-parent'  = '#tenantInfoAccordion'
                                } -Content {
                                    New-PSHtmldiv -class 'accordion-body bg-light' -Content $TenantInfoBasics.Organization.technicalNotificationMails
                                }
                            }
                            #Object Usage Progress
                            New-PSHtmldiv -class 'accordion-item' -Content {
                                New-PSHtmlh2 -class 'accordion-header' -id 'ObjectUsageHead' -Content {
                                    New-PSHtmlbutton -class 'accordion-button' -OtherAttributes @{
                                        'type' = 'button'
                                        'data-bs-toggle' = 'collapse'
                                        'data-bs-target' = '#ObjectUsageCollapse'
                                        'aria-controls'  = 'ObjectUsageCollapse'
                                    } -Content 'Object Quota Usage'
                                }
                                New-PSHtmldiv -id 'ObjectUsageCollapse' -class 'accordion-collapse collapse show' -OtherAttributes @{
                                    'aria-labelledby' = 'ObjectUsageHead'
                                    'data-bs-parent'  = '#tenantInfoAccordion'
                                } -Content {
                                    New-PSHtmldiv -class 'accordion-body bg-light' -Content {
                                        New-PSHtmlDiv -class 'container-fluid' -Content {
                                            New-PSHtmlDiv -class 'progress' -Content {
                                                $Average = $TenantInfoBasics.Organization.directorySizeQuota.used/$TenantInfoBasics.Organization.directorySizeQuota.total*100
                                                New-PSHtmlDiv -class 'progress-bar' -style "width: $Average%;" -OtherAttributes @{
                                                    'role' = 'progressbar'
                                                    'aria-valuenow' = $Average
                                                    'aria-valuemin' = '0'
                                                    'aria-valuemax' = '100'
                                                } -Content ('{0}/{1}' -f $TenantInfoBasics.Organization.directorySizeQuota.used, $TenantInfoBasics.Organization.directorySizeQuota.total)
                                            }
                                        }
                                    }
                                }
                            }
                            #Domain Details
                            New-PSHtmldiv -class 'accordion-item' -Content {
                                New-PSHtmlh2 -class 'accordion-header' -id 'DNSDomainsLabel' -Content {
                                    New-PSHtmlbutton -class 'accordion-button' -OtherAttributes @{
                                        'type'           = 'button'
                                        'data-bs-toggle' = 'collapse'
                                        'data-bs-target' = '#DNSDomainsCollapse'
                                        'aria-controls'  = 'DNSDomainsCollapse'
                                    } -Content 'Domains registered for the tenant'
                                }
                                New-PSHtmldiv -id 'DNSDomainsCollapse' -class 'accordion-collapse collapse show' -OtherAttribute @{
                                    'aria-labelledby' = 'DNSDomainsLabel'
                                    'data-bs-parent'  = '#tenantInfoAccordion'
                                } -Content {
                                    New-PSHtmlDiv -class 'container-fluid' -Content {
                                        New-PSHtmlP -Content ''
                                        New-PSHtmlBootstrapTable -TableId 'DNSDomainDetails' -Data $($TenantInfoBasics.Organization.verifiedDomains | Select-Object -Property Id,AuthenticationType,IsDefault,IsInitial,IsVerified,@{
                                            Name = 'SupportedServices'
                                            Expression = {
                                                $_.supportedServices -join ', '
                                            }
                                        }) -PropertiesMap @(
                                            @{
                                                field = 'id'
                                                title = 'Name'
                                            }, @{
                                                field = 'authenticationType'
                                                title = 'Authentication Type'
                                            }, @{
                                                field = 'isDefault'
                                                title = 'Default Domain'
                                            }, @{
                                                field = 'isInitial'
                                                title = 'Initial Domain'
                                            }, @{
                                                field = 'isVerified'
                                                title = 'Verification Done'
                                            }, @{
                                                field = 'SupportedServices'
                                                title = 'Service available'
                                            }
                                        ) -Searchable -Paged -Sortable
                                    }
                                }
                            }
                            #External Tenant usage
                            New-PSHtmldiv -class 'accordion-item' -Content {
                                $ExternalTenants = ($Outputs | Where-Object -FilterScript {$_.Id -eq 'TI0004'}).Result
                                New-PSHtmlh2 -class 'accordion-header' -id 'ExternalTenantUsageLabel' -Content {
                                    New-PSHtmlbutton -class 'accordion-button' -OtherAttributes @{
                                        'type'           = 'button'
                                        'data-bs-toggle' = 'collapse'
                                        'data-bs-target' = '#ExternalTenantUsageCollapse'
                                        'aria-controls'  = 'ExternalTenantUsageCollapse'
                                    } -Content 'External Identities Tenant usage'
                                }
                                New-PSHtmldiv -id 'ExternalTenantUsageCollapse' -class 'accordion-collapse collapse show' -OtherAttribute @{
                                    'aria-labelledby' = 'ExternalTenantUsageLabel'
                                    'data-bs-parent'  = '#tenantInfoAccordion'
                                } -Content {
                                    New-PSHtmlDiv -class 'container-fluid' -Content {
                                        New-PSHtmlP -Content ''
                                        New-PSHtmlBootstrapTable -TableId 'ExternalTenantUsageDetails' -Searchable -Paged -Sortable -Data $($ExternalTenants | ForEach-Object -Process {
                                            $DNSDomains = $_.Group.DomainName | Group-Object | Sort-Object -Property Count -Descending
                                            if ($_.Name -eq '9cd80435-793b-4f48-844b-6b3f37d1c1f3') {
                                                $TenantName = 'Personal Email Addresses'
                                            } else {
                                                $TenantName = ($DNSDomains | Select-Object -First 1).Name
                                            }
                                            [PSCustomObject][Ordered]@{
                                                Name            = $TenantName
                                                TenantId        = $_.Name
                                                Region          = $($_.Group.Region | Get-Unique)
                                                NumberOfGuests  = $_.Count
                                                NumberOfDomains = $DNSDomains.Count
                                                DomainNames     = $(($DNSDomains | ForEach-Object -Process {'{0}: {1}' -f $_.Name, $_.Count}) -join [System.Environment]::NewLine)
                                            }
                                        }) -PropertiesMap @(
                                            @{
                                                field = 'Name'
                                                title = 'Name'
                                            }, @{
                                                field = 'TenantId'
                                                title = 'Tenant Id'
                                            }, @{
                                                field = 'Region'
                                                title = 'Tenant Region'
                                            }, @{
                                                field = 'NumberOfGuests'
                                                title = 'Number Of Guests'
                                            }, @{
                                                field = 'NumberOfDomains'
                                                title = 'Number Of Domains'
                                            }, @{
                                                field = 'DomainNames'
                                                title = 'Domain Names usage'
                                            }
                                        )
                                    }
                                }
                            }
                            #Accounts Analysis
                            New-PSHtmldiv -class 'accordion-item' -Content {
                                New-PSHtmlh2 -class 'accordion-header' -id 'AccountsAnalysisLabel' -Content {
                                    New-PSHtmlButton -class 'accordion-button' -OtherAttributes @{
                                        'type'           = 'button'
                                        'data-bs-toggle' = 'collapse'
                                        'data-bs-target' = '#AccountsAnalysis'
                                        'aria-controls'  = 'AccountsAnalysis'
                                    } -Content 'Account analysis'
                                }
                                New-PSHtmldiv -id 'AccountsAnalysis' -class 'accordion-collapse collapse show' -OtherAttribute @{
                                    'aria-labelledby' = 'AccountsAnalysisLabel'
                                    'data-bs-parent'  = '#tenantInfoAccordion'
                                } -Content {
                                    $AccountsAnalysis = ($Outputs | Where-Object -FilterScript {$_.Id -eq 'TI0002'}).Result
                                    New-PSHtmlDiv -class 'container-fluid' -Content {
                                        New-PSHtmlTable -class 'table table-striped' -Content {
                                            New-PSHtmlThead -class 'table-dark' -Content {
                                                New-PSHtmlTr -Content {
                                                    New-PSHtmlTd -Content 'Nb User Accounts'
                                                    New-PSHtmlTd -Content 'Nb User Guests'
                                                    New-PSHtmlTd -Content 'Nb User Members'
                                                    New-PSHtmlTd -Content 'Nb User Members sync on premise'
                                                    New-PSHtmlTd -Content 'Nb User Members Pure Azure'
                                                    New-PSHtmlTd -Content 'Password never expires'
                                                }
                                            }
                                            New-PSHtmlTbody -Content {
                                                New-PSHtmlTd -Content $AccountsAnalysis.AnalysisTable.AccountsCount
                                                New-PSHtmlTd -Content $AccountsAnalysis.AnalysisTable.GuestAccounts
                                                New-PSHtmlTd -Content $AccountsAnalysis.AnalysisTable.MemberAccounts
                                                New-PSHtmlTd -Content $AccountsAnalysis.AnalysisTable.SyncedMembers
                                                New-PSHtmlTd -Content $AccountsAnalysis.AnalysisTable.CloudMembers
                                                New-PSHtmlTd -Content $AccountsAnalysis.AnalysisTable.CloudPwdNeverExpire
                                            }
                                        }
                                        New-PSHtmlDiv -class 'card-group' -Content {
                                            New-PSHtmlDiv -class 'card' -Content {
                                                New-PSHtmlDiv -class 'card-body' -Content {
                                                    New-PSHtmlH5 -class 'card-title' -Content 'Users per type'
                                                    New-PSHtmlChartJS -ChartId 'UserTypeRepartitionChart' -ChartType 'doughnut' -InputObject $AccountsAnalysis.Repartition
                                                }
                                            }
                                            New-PSHtmlDiv -class 'card' -Content {
                                                New-PSHtmlDiv -class 'card-body' -Content {
                                                    New-PSHtmlH5 -class 'card-title' -Content 'Synchronized users'
                                                    [Collections.ArrayList]$UsersPerSyncType = @()
                                                    $null = $UsersPerSyncType.Add(@{'Synced Members' = $AccountsAnalysis.AnalysisTable.SyncedMembers})
                                                    $null = $UsersPerSyncType.Add(@{'Cloud Members' = $AccountsAnalysis.AnalysisTable.CloudMembers})
                                                    New-PSHtmlChartJS -ChartId 'UsersPerSyncType' -ChartType 'doughnut' -InputObject $UsersPerSyncType -ArrayTitleProperty 'Name' -ArrayValueProperty 'Value'
                                                }
                                            }
                                            New-PSHtmlDiv -class 'card' -Content {
                                                New-PSHtmlDiv -class 'card-body' -Content {
                                                    New-PSHtmlH5 -class 'card-title' -Content 'Cloud users with password never expires'
                                                    [Collections.ArrayList]$UsersPerPwdPolicy = @()
                                                    $null = $UsersPerPwdPolicy.Add(@{'No policy' = ($AccountsAnalysis.AnalysisTable.CloudMembers - $AccountsAnalysis.AnalysisTable.CloudPwdNeverExpire)})
                                                    $null = $UsersPerPwdPolicy.Add(@{'Password Never Expire' = $AccountsAnalysis.AnalysisTable.CloudPwdNeverExpire})
                                                    New-PSHtmlChartJS -ChartId 'UsersPerPwdPolicy' -ChartType 'doughnut' -InputObject $UsersPerPwdPolicy -ArrayTitleProperty 'Name' -ArrayValueProperty 'Value'
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                #Azure AD Indicators
                New-PSHtmlDiv -class 'card bg-light mb-2' -id 'AzureADIndicatorCard' -Content {
                    $AzureADIndicatorsCardId = 'AzureADIndicators'
                    New-PSHtmlDiv -class 'card-header' -OtherAttributes @{
                        'data-bs-toggle' = 'collapse'
                        'data-bs-target' = "#$AzureADIndicatorsCardId"
                        'aria-expanded' = $true
                        'aria-controls' = $AzureADIndicatorsCardId
                    } -Content {
                        New-PSHtmlH5 -Content 'Azure AD Indicators'
                    }
                    New-PSHtmlDiv -class 'card-body collapse show' -id $AzureADIndicatorsCardId -Content {
                        New-PSHtmlH2 -Content 'MITRE ATT&CK'
                        New-PSHtmlDiv -class 'row justify-content-center' -Content {
                            New-PSHtmldiv -class 'col-10 row row-cols-1 row-cols-md-3 g-4' -Content {
                                foreach ($category in ($Categories | Where-Object -FilterScript {$_.Indicator -eq $true})) {
                                    $History         = $IndicatorsHistory | Where-Object -FilterScript {$_.Name -eq $category.Name}
                                    $AllScoreResults = ($Outputs | Where-Object -FilterScript {$_.CategoryId -eq $category.Id}).Result.Score | Measure-Object -Sum
                                    $CategoryScore   = [Math]::Round(($AllScoreResults.Sum / $AllScoreResults.Count), 2)
                                    if ($CategoryScore -eq 0) {
                                        $Level = 'danger'
                                    } elseif ($CategoryScore -lt 100) {
                                        $Level = 'warning'
                                    } else {
                                        $Level = 'success'
                                    }

                                    #Write HTML Indicator
                                    New-PSHTmldiv -class 'col' -Content {
                                        New-PSHTmldiv -class "card bg-light border-$Level" -Content {
                                            New-PSHTmldiv -class "card-body row text-$Level" -Content {
                                                New-PSHtmlDiv -class 'col-8' -Content {
                                                    New-PSHTmlh5 -class 'card-title' -Content $category.Name
                                                    New-PSHtmlChartJS -ChartId "$($category.Name -replace ' ','')History" -ChartType 'line' -ArrayTitleProperty Date -ArrayValueProperty Score -InputObject $History -HideLegend -LineShowX $false -DatasetLabel $category.Name
                                                }
                                                New-PSHtmlDiv -class 'col-4 text-end' -style 'font-size: xxx-large;' -title $CategoryScore -Content {if ($null -ne $CategoryScore) {[Math]::Round($CategoryScore, 0)} else {0}}
                                            }
                                            New-PSHtmlDiv -class "card-footer text-center border-$Level" -Content {
                                                New-PSHtmlA -href "#Card$($category.Id)" -class 'btn btn-primary btn-sm' -Content 'Details'
                                            }
                                        }
                                    }

                                    #Add Indicator to Outputs, to write them in the XML file
                                    $null = $Indicators.Add(([PSCustomObject]@{
                                        Name  = $category.Name
                                        Score = $CategoryScore
                                        Level = $Level
                                    }))
                                }
                            }
                        }
                    }
                }
                #Looping in all categories output and generating Html Cards
                foreach ($category in $Categories) {
                    $CardHtmlId = $category.Name.Replace(' ','')
                    $Items = $Outputs | Where-Object -FilterScript {$_.CategoryId -eq $category.Id}
                    New-PSHtmlDiv -class 'card bg-light mb-2' -id "Card$($category.Id)" -Content {
                        New-PSHtmlDiv -class 'card-header' -OtherAttributes @{
                            'data-bs-toggle' = 'collapse'
                            'data-bs-target' = "#$CardHtmlId"
                            'aria-expanded' = $true
                            'aria-controls' = $CardHtmlId
                        } -Content {
                            New-PSHtmlH5 -Content {
                                New-PSHtmlDiv -class 'row' -Content {
                                    New-PSHtmlDiv -class 'col-10' -Content $category.Name
                                    New-PSHtmlDiv -class 'col-2' -Content {
                                        $AllScoreResults = $Items.Result.Score | Measure-Object -Sum
                                        $CategoryScore = [Math]::Round(($AllScoreResults.Sum / $AllScoreResults.Count), 2)
                                        if ($CategoryScore -eq 0) {
                                            $CategoryBadgeColor = 'danger'
                                            $CategoryStatus     = 'Failed'
                                        } elseif ($CategoryScore -lt 100) {
                                            $CategoryBadgeColor = 'warning'
                                            $CategoryStatus     = 'Warning'
                                        } else {
                                            $CategoryBadgeColor = 'success'
                                            $CategoryStatus     = 'Pass'
                                        }
                                        New-PSHtmlSpan -class "badge bg-$CategoryBadgeColor" -Content "$CategoryScore - $CategoryStatus"
                                    }
                                }
                            }
                        }
                        New-PSHtmlDiv -class 'card-body collapse show' -id $CardHtmlId -Content {
                            New-PSHtmlP -Content $category.Description
                            New-PSHtmlDiv -class 'accordion' -id "$($CardHtmlId)Accordion" -Content {
                                foreach ($entry in $Items) {
                                    New-PSHtmlDiv -class 'accordion-item' -Content {
                                        New-PSHtmlH2 -class 'accordion-header' -id "$($entry.Id)-heading" -title $entry.ScriptName -Content {
                                            New-PSHtmlDiv -class 'accordion-button' -OtherAttributes @{
                                                'data-bs-toggle' = 'collapse'
                                                'data-bs-target' = "#$($entry.Id)"
                                                'aria-expanded'  = $true
                                                'aria-controls'  = $entry.Id
                                            } -Content {
                                                New-PSHtmlDiv -class 'row container-fluid' -Content {
                                                    New-PSHtmlDiv -class 'col-10' -Content $entry.Title
                                                    New-PSHtmlDiv -class 'col-2 text-end' -Content {
                                                        if ($entry.Result.Score -eq 0) {
                                                            $BgColor = 'danger'
                                                        } elseif ($entry.Result.Score -gt 0 -and $entry.Result.Score -lt 100) {
                                                            $BgColor = 'warning'
                                                        } else {
                                                            $BgColor = 'success'
                                                        }
                                                        New-PSHtmlSpan -class "mx-2 badge bg-$BgColor" -Content "$($entry.Result.Score) - $($entry.Result.Status)"
                                                    }
                                                }
                                                
                                            }
                                        }
                                        New-PSHtmlDiv -id $entry.Id -class 'accordion-collapse collapse show' -OtherAttributes @{
                                            'aria-labelledby' = "$($entry.Id)-heading"
                                            'data-bs-parent'  = "$($CardHtmlId)Accordion"
                                        } -Content {
                                            New-PSHtmldiv -class 'accordion-body bg-light' -Content {
                                                #Breadcrumb & Script run infos
                                                New-PSHtmlDiv -class 'row' -Content {
                                                    New-PSHtmlDiv -class 'col-11' -Content {
                                                        New-PSHtmlNav -OtherAttributes @{'aria-label'='breadcrumb'} -Content {
                                                            New-PSHtmlOl -class 'breadcrumb' -Content {
                                                                New-PSHtmlLi -class 'breadcrumb-item' -Content {
                                                                    New-PSHtmlA -href "#Card$($category.Id)" -Content $category.Name
                                                                }
                                                                New-PSHtmlLi -class 'breadcrumb-item active' -OtherAttributes @{'aria-current' = 'page'} -Content $entry.Title
                                                            }
                                                        }
                                                    }
                                                    New-PSHtmlDiv -Class 'col-1' -Content {
                                                        New-PSHTmlButton -class 'btn btn-primary' -OtherAttributes @{
                                                            'type'           = 'button'
                                                            'data-bs-toggle' = 'offcanvas'
                                                            'data-bs-target' = "#offcanvas$($entry.Id)"
                                                            'aria-controls'  = "offcanvas$($entry.Id)"
                                                        } -style '--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;' -Content 'Script Details'
                                                        New-PSHtmlDiv -class 'offcanvas offcanvas-end bg-light' -style 'width: 50vw;' -id "offcanvas$($entry.Id)" -OtherAttributes @{
                                                            'tabindex' = -1
                                                            'aria-labelledby' = "offcanvas$($entry.Id)Label"
                                                        } -Content {
                                                            New-PSHtmldiv -class 'offcanvas-header' -Content {
                                                                New-PSHtmlh5 -class 'offcanvas-title' -id "offcanvas$($entry.Id)Label" -Content 'Script Details'
                                                                New-PSHtmlbutton -class 'btn-close' -OtherAttributes @{
                                                                    'type'            = 'button'
                                                                    'data-bs-dismiss' = "offcanvas"
                                                                    'aria-label'      = 'Close'
                                                                }
                                                            }
                                                            New-PSHtmldiv -class 'offcanvas-body' -Content {
                                                                New-PSHtmlnav -Content {
                                                                    New-PSHtmldiv -class 'nav nav-tabs' -id 'nav-tab' -OtherAttributes @{role='tablist'} -Content {
                                                                        New-PSHtmlbutton -class 'nav-link active' -id "$($entry.Id)ScriptInfo-tab" -OtherAttributes @{
                                                                            'data-bs-toggle' = 'tab'
                                                                            'data-bs-target' = "#$($entry.Id)ScriptInfo"
                                                                            'type'           = 'button'
                                                                            'role'           = 'tab'
                                                                            'aria-controls'  = "$($entry.Id)ScriptInfo"
                                                                            'aria-selected'  = $true
                                                                        } -Content 'Script Info'
                                                                        New-PSHtmlbutton -class 'nav-link' -id "$($entry.Id)AADPermissions-tab" -OtherAttributes @{
                                                                            'data-bs-toggle' = 'tab'
                                                                            'data-bs-target' = "#$($entry.Id)AADPermissions"
                                                                            'type'           = 'button'
                                                                            'role'           = 'tab'
                                                                            'aria-controls'  = "$($entry.Id)AADPermissions"
                                                                            'aria-selected'  = $false
                                                                        } -Content 'Azure AD Permissions'
                                                                        New-PSHtmlbutton -class 'nav-link' -id "$($entry.Id)ScriptChangeLog-tab" -OtherAttributes @{
                                                                            'data-bs-toggle' = 'tab'
                                                                            'data-bs-target' = "#$($entry.Id)ScriptChangeLog"
                                                                            'type'           = 'button'
                                                                            'role'           = 'tab'
                                                                            'aria-controls'  = "$($entry.Id)ScriptChangeLog"
                                                                            'aria-selected'  = $false
                                                                        } -Content 'Script Change Log'
                                                                    }
                                                                }
                                                                New-PSHtmldiv -class 'tab-content mt-2' -Content {
                                                                    New-PSHtmldiv -class 'tab-pane fade show active' -id "$($entry.Id)ScriptInfo" -OtherAttributes @{
                                                                        'role'            = 'tabpanel'
                                                                        'aria-labelledby' = "$($entry.Id)ScriptInfo-tab"
                                                                        'tabindex'        = 0
                                                                    } -Content {
                                                                        New-PSHtmlTable -class 'table table-stripped' -Content {
                                                                            New-PSHtmlTr -Content {
                                                                                New-PSHtmlTh -Content 'Version'
                                                                                New-PSHtmlTd -Content $($entry.ChangeLog | Sort-Object -Property Date -Descending | Select-Object -First 1 -ExpandProperty Version)
                                                                            }
                                                                            New-PSHtmlTr -Content {
                                                                                New-PSHtmlTh -Content 'Execution time'
                                                                                New-PSHtmlTd -Content $entry.Result.Timespan
                                                                            }
                                                                        }
                                                                    }
                                                                    New-PSHtmldiv -class 'tab-pane fade' -id "$($entry.Id)AADPermissions" -OtherAttributes @{
                                                                        'role'            = 'tabpanel'
                                                                        'aria-labelledby' = "$($entry.Id)AADPermissions-tab"
                                                                        'tabindex'        = 0
                                                                    } -Content {
                                                                        New-PSHtmlP -Content 'Required GraphAPI permissions:'
                                                                        New-PSHtmlUl -Content {
                                                                            $entry.Permissions | ForEach-Object -Process {
                                                                                New-PSHtmlLi -Content $_
                                                                            }
                                                                        }                    
                                                                    }
                                                                    New-PSHtmldiv -class 'tab-pane fade' -id "$($entry.Id)ScriptChangeLog" -OtherAttributes @{
                                                                        'role'            = 'tabpanel'
                                                                        'aria-labelledby' = "$($entry.Id)ScriptChangeLog-tab"
                                                                        'tabindex'        = 0
                                                                    } -Content {
                                                                        New-PSHtmlP -Content 'Script Change Log:'
                                                                        (New-PSHtmlBootstrapTable -TableId "$($entry.Id)ChangeLogTable" -Data $entry.ChangeLog -Searchable -Paged -Sortable -PropertiesMap @(
                                                                            @{
                                                                                field = 'Version'
                                                                                title = 'Version'
                                                                            }, @{
                                                                                field = 'ChangeLog'
                                                                                title = 'Changes'
                                                                            }, @{
                                                                                field = 'Date'
                                                                                title = 'Date'
                                                                            }, @{
                                                                                field = 'Author'
                                                                                title = 'Author'
                                                                            }
                                                                        ))# -replace '"\\/Date(','Date(' -replace ')\\/"',')'
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }                        
                                                #Header
                                                New-PSHtmlDiv -class 'row py-2 border-bottom border-top' -Content {
                                                    New-PSHtmlDiv -class 'col-4 border-end' -Content {
                                                        New-PSHtmlH4 -Content 'Severity'
                                                        New-PSHtmlDiv -class 'row' -Content {
                                                            New-PSHtmlDiv -class 'col-4' -Content $entry.Severity
                                                            New-PSHtmlDiv -class 'col-5' -Content {
                                                                New-PSHtmlDiv -class 'progress' -Content {
                                                                    if ($entry.Severity -match 'Informational|Warning|Critical') {
                                                                        New-PSHtmlDiv -class 'progress-bar bg-success' -style 'width: 33.33%' -OtherAttributes @{
                                                                            'role'          = 'progressbar'
                                                                            'aria-valuenow' = '33.33'
                                                                            'aria-valuemin' = '0'
                                                                            'aria-valuemax' = '100'
                                                                        }
                                                                    }
                                                                    if ($entry.Severity -match 'Warning|Critical') {
                                                                        New-PSHtmlDiv -class 'progress-bar bg-warning' -style 'width: 33.33%' -OtherAttributes @{
                                                                            'role'          = 'progressbar'
                                                                            'aria-valuenow' = '33.33'
                                                                            'aria-valuemin' = '0'
                                                                            'aria-valuemax' = '100'
                                                                        }
                                                                    }
                                                                    if ($entry.Severity -eq 'Critical') {
                                                                        New-PSHtmlDiv -class 'progress-bar bg-danger' -style 'width: 33.33%' -OtherAttributes @{
                                                                            'role'          = 'progressbar'
                                                                            'aria-valuenow' = '33.33'
                                                                            'aria-valuemin' = '0'
                                                                            'aria-valuemax' = '100'
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                    }
                                                    New-PSHtmlDiv -class 'col-6' -Content {
                                                        New-PSHtmlH4 -Content 'Weight'
                                                        $entry.Weight
                                                    }
                                                }
                                                #Security Framework source
                                                New-PSHtmlDiv -class 'py-2' -Content {
                                                    New-PSHtmlH4 -Content 'Security Frameworks'
                                                    foreach ($framework in $entry.SecurityFrameworks) {
                                                        New-PSHtmlB -Content $framework.Name
                                                        New-PSHtmlUl -Content {
                                                            $framework.Tags | ForEach-Object -Process {
                                                                New-PSHtmlLi -Content $_
                                                            }
                                                        }
                                                    }
                                                }
                                                #Description
                                                New-PSHtmlDiv -class 'py-2' -Content {
                                                    New-PSHtmlH4 -Content 'Description'
                                                    New-PSHtmlP -Content $entry.Description
                                                }
                                                #Likelihood of Compromise
                                                New-PSHtmlDiv -class 'py-2' -Content {
                                                    New-PSHtmlH4 -Content 'Likelihood of Compromise'
                                                    New-PSHtmlP -Content $entry.LikelihoodOfCompromise
                                                }
                                                #Result
                                                New-PSHtmlDiv -class 'py-2' -Content {
                                                    New-PSHtmlH4 -Content 'Result'
                                                    New-PSHtmlP -Content $entry.Result.Message
                                                }
                                                #Remediation Steps
                                                New-PSHtmlDiv -class 'py-2' -Content {
                                                    New-PSHtmlH4 -Content 'Remediation Steps'
                                                    New-PSHtmlP -Content $entry.Result.Remediation
                                                }
                                                #Output data
                                                if (![String]::IsNullOrEmpty($entry.Result.Data)) {
                                                    New-PSHtmlDiv -class 'py-2' -Content {
                                                        New-PSHtmlH4 -Content 'Report Data'
                                                        New-PSHtmlP -Content 'Here is what has been found:'
                                                        New-PSHtmlBootstrapTable -TableId "$($entry.Id)table" -Data $entry.Result.Data -Searchable -Paged -Sortable
                                                        #$HtmlOut = New-PSHtmlBootstrapTable -TableId "$($entry.Id)table" -Data $entry.Result.Data -Searchable -Paged -Sortable
                                                        #if ($HtmlOut -match '"\\/Date(') {
                                                        #    $HtmlOut -replace '"\\/Date(','Date(' -replace ')\\/"',')'
                                                        #}
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        New-PSHtmlScript -Content @'
(function () {
    function onToggleMode() {
        if (lightSwitch.checked) {
            document.querySelectorAll('.bg-light').forEach((element) => {
                element.className = element.className.replace(/-light/g, '-dark');
            });
            document.querySelectorAll('.btn-light').forEach((element) => {
                element.className = element.className.replace(/-light/g, '-dark');
            });

            document.body.classList.add('bg-dark');

            if (document.body.classList.contains('text-dark')) {
                document.body.classList.replace('text-dark', 'text-light');
            } else {
                document.body.classList.add('text-light');
            }

            // Tables
            var tables = document.querySelectorAll('table');
            for (var i = 0; i < tables.length; i++) {
                tables[i].classList.add('table-dark');
            }

            // set light switch input to true
            if (!lightSwitch.checked) {
                lightSwitch.checked = true;
            }
            localStorage.setItem('lightSwitch', 'dark');
        } else {
            document.querySelectorAll('.bg-dark').forEach((element) => {
                element.className = element.className.replace(/-dark/g, '-light');
            });
            document.querySelectorAll('.btn-dark').forEach((element) => {
                element.className = element.className.replace(/-dark/g, '-light');
            });
            document.body.classList.add('bg-light');

            if (document.body.classList.contains('text-light')) {
                document.body.classList.replace('text-light', 'text-dark');
            } else {
                document.body.classList.add('text-dark');
            }

            // Tables
            var tables = document.querySelectorAll('table');
            for (var i = 0; i < tables.length; i++) {
                if (tables[i].classList.contains('table-dark')) {
                    tables[i].classList.remove('table-dark');
                }
            }

            if (lightSwitch.checked) {
                lightSwitch.checked = false;
            }
            localStorage.setItem('lightSwitch', 'light');
        }
    }
    let lightSwitch = document.getElementById('lightSwitch');
    lightSwitch.addEventListener('change', onToggleMode);
    onToggleMode();
})();
        
'@
    }
} | Out-File -FilePath "$BaseOutputFilePath.html" -Encoding 'utf8' -Force

#Out XML File
Write-Output -InputObject 'Start generating XML content and file'
@{
    Indicators = $Indicators
    RawData    = $Outputs
} | Export-Clixml -Path "$BaseOutputFilePath.xml" -Depth 99 -Encoding UTF8 -Force
#endregion Generating HTML and XML Output File

#Write end message and open HTML File
Write-Output -InputObject "Script took $(New-TimeSpan -Start $Start -End (Get-Date)) to run."
Write-Output -InputObject 'Output files are available:'
Write-Output -InputObject "`tHTML: $BaseOutputFilePath.html"
Write-Output -InputObject "`tXML : $BaseOutputFilePath.xml"

if ($OpenHtml) {
    Start-Process -FilePath "$BaseOutputFilePath.html"
}
#endregion Main