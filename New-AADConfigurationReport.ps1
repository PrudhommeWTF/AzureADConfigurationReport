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
Function Write-LogFileEntry {
    <#
        .SYNOPSIS
        Write formated entry in the PowerShell Host and a file.

        .DESCRIPTION
        Function to write message within the PowerShell Host and persist it into a select file.

        .PARAMETER Info
        Message to write as basic information.
        It will be displayed as Verbose in the PowerShell Host.

        .PARAMETER Warning
        Message to write as a warning information.
        It will be displayed as Warning in the PowerShell Host.

        .PARAMETER Debugging
        Message to write as a debugging information.
        It will be displayed as Debug in the PowerShell Host

        .PARAMETER ErrorMessage
        Message to write as error information.
        It will be de displayed as an Error message in the PowerShell Host.

        .PARAMETER Success
        Message to write as a success information.
        It will be displayed in grenn as a successfull message in the PowerShell Host.

        .PARAMETER ErrorRecord
        Used to complete the ErrorMessage parameter with the Error Object that may have been generated.
        This information will be displayed in the persistance file.

        .PARAMETER LogFile
        Specify the file to write messages in.

        .NOTES
        Author: Thomas Prud'homme (Blog: https://blog.prudhomme.wtf Tw: @Prudhomme_WTF).

        .LINK
        https://github.com/PrudhommeWTF/Stuffs/blob/master/Write-LogFileEntry/Write-LogFileEntry.md

        .INPUTS
        System.String

        .OUTPUTS
        System.IO.File
    #>
    [CmdletBinding(
        DefaultParameterSetName = 'Info',
        SupportsShouldProcess   = $true,
        ConfirmImpact           = 'Medium',
        HelpUri                 = 'https://github.com/PrudhommeWTF/Stuffs/blob/master/Write-LogFileEntry/Write-LogFileEntry.md'
    )]
    Param(
        [Parameter(
            Mandatory                       = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName                = 'Info'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Message')]
        [String]$Info,

        [Parameter(
            Mandatory                       = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName                = 'Warning'
        )]
        [ValidateNotNullOrEmpty()]
        [String]$Warning,

        [Parameter(
            Mandatory                       = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName                = 'Debugging'
        )]
        [ValidateNotNullOrEmpty()]
        [String]$Debugging,

        [Parameter(
            Mandatory                       = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName                = 'ErrorMessage'
        )]
        [ValidateNotNullOrEmpty()]
        [String]$ErrorMessage,

        [Parameter(
            Mandatory                       = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName                = 'Success'
        )]
        [ValidateNotNullOrEmpty()]
        [String]$Success,

        [Parameter(
            ValueFromPipeline               = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments     = $false,
            ParameterSetName                = 'ErrorMessage'
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('Record')]
        [Management.Automation.ErrorRecord]$ErrorRecord,

        [Parameter(
            Mandatory                       = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [Alias('File', 'Location')]
        [String]$LogFile
    )
    if (!(Test-Path -Path $LogFile)) {
        try {
            $null = New-Item -Path $LogFile -ItemType File -Force
        }
        catch {
            Write-Error -Message 'Error creating log file'
            break
        }
    }
    $MutexName = 'AzureADConfigReport'
    try {
        $Mutex = [Threading.Mutex]::OpenExisting($MutexName)
    }
    catch {
        $Mutex = New-Object -TypeName 'Threading.Mutex' -ArgumentList $false, $MutexName
    }

    switch ($PSBoundParameters.Keys) {
         'ErrorMessage' {
            Write-Host -Object "ERROR  : [$([DateTime]::Now)] $ErrorMessage" -ForegroundColor Red
            $null = $Mutex.WaitOne()
            Add-Content -Path $LogFile -Value "$([DateTime]::Now) [ERROR]: $ErrorMessage"
            if ($PSBoundParameters.ContainsKey('ErrorRecord')) {
                $Details = '{0} ({1}: {2}:{3} char:{4})' -f $ErrorRecord.Exception.Message, $ErrorRecord.FullyQualifiedErrorId, $ErrorRecord.InvocationInfo.ScriptName, $ErrorRecord.InvocationInfo.ScriptLineNumber, $ErrorRecord.InvocationInfo.OffsetInLine
                Write-Host -Object "ERROR  : [$([DateTime]::Now)] $Details" -ForegroundColor Red
                Add-Content -Path $LogFile -Value "$([DateTime]::Now) [ERROR]: $Details"
            }
            $null = $Mutex.ReleaseMutex()
            Continue
         }
         'Info' {
            $VerbosePreference = 'Continue'
            Write-Verbose -Message "[$([DateTime]::Now)] $Info"
            $null = $Mutex.WaitOne()
            Add-Content -Path $LogFile -Value "$([DateTime]::Now) [INFO]: $Info"
            $null = $Mutex.ReleaseMutex()
            Continue
         }
         'Debugging' {
            Write-Debug -Message "$Debugging"
            $null = $Mutex.WaitOne()
            Add-Content -Path $LogFile -Value "$([DateTime]::Now) [DEBUG]: $Debugging"
            $null = $Mutex.ReleaseMutex()
            Continue
         }
         'Warning' {
            Write-Warning -Message "[$([DateTime]::Now)] $Warning"
            $null = $Mutex.WaitOne()
            Add-Content -Path $LogFile -Value "$([DateTime]::Now) [WARNING]: $Warning"
            $null = $Mutex.ReleaseMutex()
            Continue
         }
         'Success' {
            Write-Host -Object "SUCCESS: [$([DateTime]::Now)] $Success" -ForegroundColor Green
            $null = $Mutex.WaitOne()
            Add-Content -Path $LogFile -Value "$([DateTime]::Now) [SUCCESS]: $Success"
            $null = $Mutex.ReleaseMutex()
            Continue
         }
    }
}
Function New-PSHtmlBootstrapTable {
    <#
        .PARAMETER PropertiesMap
        Hashtable to map $Data properties to Table Header

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

        [Switch]$Paged
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
        columns = $PropertiesMap
        data    = $Data
    }
    if ($Searchable) {
        $null = $BootstrapTable.Add('search', $true)
    }
    if ($Paged) {
        $null = $BootstrapTable.Add('pagination', $true)
    }

    New-PSHtmlTable -class 'table table-striped' -id $TableId
    New-PSHtmlScript -Content "`$('#$TableId').bootstrapTable($($BootstrapTable | ConvertTo-Json -Compress))"
}
Function New-RandomRGBA {
    $Random = [Drawing.Color]::FromArgb((Get-Random -Maximum 256),(Get-Random -Maximum  256),(Get-Random -Maximum  256),(Get-Random -Maximum  256))
    'rgba({0}, {1}, {2}, {3})' -f $Random.R, $Random.G, $Random.B, $Random.A
}
Function New-PSHtmlChartJS {
    Param(
        $ChartId = 'myChart',
        $ChartType,
        $ArrayTitleProperty = 'Name',
        $ArrayValueProperty = 'Count',
        $InputObject
    )

    [Collections.ArrayList]$Labels = @()
    [Collections.ArrayList]$Data = @()
    [Collections.ArrayList]$ColorSet = @()
    [Collections.Hashtable]$Dataset = @{}

    if ($InputObject -is [Array]) {
        $InputObject | ForEach-Object -Process {
            $null = $Labels.Add($_.$ArrayTitleProperty)
            $null = $Data.Add($_.$ArrayValueProperty)
            if ($ChartType -ne 'line') {
                $null = $ColorSet.Add((New-RandomRGBA))
            }
        }
    } elseif ($InputObject -is [Collections.ArrayList]) {
        $Labels = $InputObject.Keys
        $Labels | ForEach-Object -Process {
            $null = $Data.Add($InputObject.$_)
            if ($ChartType -ne 'line') {
                $null = $ColorSet.Add((New-RandomRGBA))
            }
        }
    } else {
        $Labels = $InputObject | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
        [Collections.ArrayList]$Data = @()
        foreach ($label in $Labels) {
            $null = $Data.Add($InputObject.$label)
            if ($ChartType -ne 'line') {
                $null = $ColorSet.Add((New-RandomRGBA))
            }
        }
    }
    $Dataset.Add('data', $Data)
    if ($ChartType -ne 'line') {
        $Dataset.Add('backgroundColor', $ColorSet)
    } else {
        $Dataset.Add('borderColor', 'rgba(13,110,253)')
    }
    [Collections.Hashtable]$Config = @{
        type = $ChartType
        data = [Collections.Hashtable]@{
            labels = $Labels
            datasets = @($Dataset)
        }
        options = [Collections.Hashtable]@{}
    }

    New-PSHtmlDiv -Content {
        New-PSHtmlCanvas -id $ChartId 
        New-PSHtmlScript -Content @'
const {0}Config = {1}
const $ChartId = new Chart(
    document.getElementById('{0}'),
    {0}Config
);
'@ -f $ChartId, $($Config | ConvertTo-Json -Depth 99 -Compress)
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
    $xaml = @'
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    SizeToContent="Height"
    Title="Azure AD Configuration Report - Configuration Tool"
    Topmost="True">
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="*"/>
            <ColumnDefinition Width="100"/>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>
      
        <TextBlock Grid.Column="0" Grid.Row="0" Margin="5">Configuration Name</TextBlock>
        <ComboBox Name="ConfigName" Grid.Column="1" Grid.Row="0" IsEditable="True" IsTextSearchEnabled="True" IsTextSearchCaseSensitive="False"></ComboBox>
        <Button Name="BtnLoadConfig" Grid.Column="2" Grid.Row="0" Width="80">Load Config</Button>

        <TextBlock Grid.Column="0" Grid.Row="1" Grid.ColumnSpan="2" Margin="5">Please Azure AD details:</TextBlock>

        <TextBlock Grid.Column="0" Grid.Row="2" Margin="5">Tenant ID</TextBlock>
        <TextBox Name="TenantId" Grid.Column="1" Grid.Row="2" Grid.ColumnSpan="2" Margin="5"></TextBox>
        <TextBlock Grid.Column="0" Grid.Row="3" Margin="5">Application ID</TextBlock>
        <TextBox Name="AppId" Grid.Column="1" Grid.Row="3" Grid.ColumnSpan="2" Margin="5"></TextBox>
        <TextBlock Grid.Column="0" Grid.Row="4" Margin="5">Application Secret</TextBlock>
        <TextBox Name="AppSecret" Grid.Column="1" Grid.Row="4" Grid.ColumnSpan="2" Margin="5"></TextBox>

      
        <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Bottom" Margin="0,10,0,0" Grid.Row="7" Grid.ColumnSpan="3">
            <Button Name="BtnOk" MinWidth="80" Height="22" Margin="5">OK</Button>
            <Button Name="BtnCancel" MinWidth="80" Height="22" Margin="5">Cancel</Button>
        </StackPanel>
    </Grid>
</Window>
'@

    #region Code Behind
    Function Convert-XAMLtoWindow {
        Param(
            [Parameter(
                Mandatory = $true
            )]
            [String]$XAML
        )
    
        Add-Type -AssemblyName PresentationFramework
        
        $reader = [XML.XMLReader]::Create([IO.StringReader]$XAML)
        $result = [Windows.Markup.XAMLReader]::Load($reader)
        $reader.Close()
        $reader = [XML.XMLReader]::Create([IO.StringReader]$XAML)
        while ($reader.Read()) {
            $name=$reader.GetAttribute('Name')
            if ($name) {
            $result | Add-Member NoteProperty -Name $name -Value $result.FindName($name) -Force
            } else {
            $name=$reader.GetAttribute('x:Name')
            }
        }
        $reader.Close()
        $result
    }

    Function Show-WPFWindow {
        Param(
            [Parameter(
                Mandatory = $true
            )]
            [Windows.Window]$Window
        )
        
        $result = $null
        $null = $window.Dispatcher.InvokeAsync{
            $result = $window.ShowDialog()
            Set-Variable -Name result -Value $result -Scope 1
        }.Wait()
        $result
    }
    #endregion Code Behind

    $window = Convert-XAMLtoWindow -XAML $xaml 

    $Configs = Get-ChildItem -Path $PSScriptRoot -Filter '*.ini'
    if ($Configs) {
        $window.ConfigName.ItemsSource = @($Configs.BaseName)
    }

    #Disable controls until a config is loaded or created
    $window.AppId.IsEnabled = $window.AppSecret.IsEnabled = $window.TenantId.IsEnabled = $false # = $window.CheckRules.IsEnabled
    $window.BtnLoadConfig.add_Click(
        {
            #Enable Controls
            $window.AppId.IsEnabled = $window.AppSecret.IsEnabled = $window.TenantId.IsEnabled = $true # = $window.CheckRules.IsEnabled
            if (Test-Path -Path "$PSScriptRoot\$($window.ConfigName.Text).ini") {
                $Config = Import-Clixml -Path "$PSScriptRoot\$($window.ConfigName.Text).ini"
                $window.TenantId.Text  = $Config.TenantId
                $window.AppId.Text     = $Config.AppId
                $window.AppSecret.Text = $Config.Secret
                #$window.CheckRules.ItemsSource = foreach ($entry in (Get-ChildItem -Path $PSScriptRoot -Filter 'CR*-*.ps1')) {
                #    if ($entry.Name -in $Config.Scripts) {
                #        [PSCustomObject]@{
                #            Name    = $entry.Name
                #            Enabled = $true
                #        }
                #    } else {
                #        [PSCustomObject]@{
                #            Name    = $entry.Name
                #            Enabled = $false
                #        }
                #    }
                #}
            } else {
                #$window.CheckRules.ItemsSource = @(Get-ChildItem -Path $PSScriptRoot -Filter 'CR*-*.ps1')
            }
        }
    )

    $window.BtnCancel.add_Click(
    {
        $window.DialogResult = $false
    }
    )
    $window.BtnOk.add_Click(
    {
        $window.DialogResult = $true
    }
    )

    $result = Show-WPFWindow -Window $window

    #region Process results
    if ($result -eq $true) {
        [PSCustomObject]@{
            TenantId = $window.TenantId.Text
            AppId    = $window.AppId.Text
            Secret   = $window.AppSecret.Text
            #Scripts  = $window.CheckRules.SelectedItems.Name
        } | Export-Clixml -Path "$PSScriptRoot\$($window.ConfigName.Text).ini" -Encoding UTF8 -Depth 99 -Force
        Write-Output -InputObject $window.ConfigName.Text
    } else {
        Write-Warning 'User aborted dialog.'
    }
    #endregion Process results
}
#endregion Functions

#region Init
$Start = Get-Date
$PSDefaultParameterValues = @{
    'Write-LogFileEntry:LogFile' = '{0}\Log\{1:yyyyMMdd_HHmm}.log' -f $PSScriptRoot, $Start
}
$ScriptTitle = 'Azure AD Configuration Report'

Write-LogFileEntry -Info ('{0} script started.' -f $ScriptTitle)

$Categories = @(
    @{
        Id = 1
        Name = 'Initial Access'
        Description = 'The adversary is trying to get into your network. Initial Access consists of techniques that use various entry vectors to gain their initial foothold within a network. Techniques used to gain a foothold include targeted spearphishing and exploiting weaknesses on public-facing web servers. Footholds gained through initial access may allow for continued access, like valid accounts and use of external remote services, or may be limited-use due to changing passwords.'
    }, @{
        Id = 2
        Name = 'Persistence'
        Description = 'The adversary is trying to maintain their foothold. Persistence consists of techniques that adversaries use to keep access to systems across restarts, changed credentials, and other interruptions that could cut off their access. Techniques used for persistence include any access, action, or configuration changes that let them maintain their foothold on systems, such as replacing or hijacking legitimate code or adding startup code.'
    }, @{
        Id = 3
        Name = 'Privilege Escalation'
        Description = 'The adversary is trying to gain higher-level permissions. Privilege Escalation consists of techniques that adversaries use to gain higher-level permissions on a system or network. Adversaries can often enter and explore a network with unprivileged access but require elevated permissions to follow through on their objectives. Common approaches are to take advantage of system weaknesses, misconfigurations, and vulnerabilities.'
    }, @{
        Id = 4
        Name = 'Defense Evasion'
        Description = "The adversary is trying to avoid being detected. Defense Evasion consists of techniques that adversaries use to avoid detection throughout their compromise. Techniques used for defense evasion include uninstalling/disabling security software or obfuscating/encrypting data and scripts. Adversaries also leverage and abuse trusted processes to hide and masquerade their malware. Other tactics' techniques are cross-listed here when those techniques include the added benefit of subverting defenses."
    }, @{
        Id = 5
        Name = 'Credential Access'
        Description = 'The adversary is trying to steal account names and passwords. Credential Access consists of techniques for stealing credentials like account names and passwords. Techniques used to get credentials include keylogging or credential dumping. Using legitimate credentials can give adversaries access to systems, make them harder to detect, and provide the opportunity to create more accounts to help achieve their goals.'
    }, @{
        Id = 6
        Name = 'Discovery'
        Description = "The adversary is trying to figure out your environment. Discovery consists of techniques an adversary may use to gain knowledge about the system and internal network. These techniques help adversaries observe the environment and orient themselves before deciding how to act. They also allow adversaries to explore what they can control and what's around their entry point in order to discover how it could benefit their current objective. Native operating system tools are often used toward this post-compromise information-gathering objective."
    }, @{
        Id = 7
        Name = 'Impact'
        Description = "The adversary is trying to manipulate, interrupt, or destroy your systems and data. Impact consists of techniques that adversaries use to disrupt availability or compromise integrity by manipulating business and operational processes. Techniques used for impact can include destroying or tampering with data. In some cases, business processes can look fine, but may have been altered to benefit the adversaries' goals. These techniques might be used by adversaries to follow through on their end goal or to provide cover for a confidentiality breach."
    }, @{
        Id = 8
        Name = 'Miscs'
        Description = 'Other indicators and checks that are not related to previous categories'
    }
)

#region Select config file
if ([String]::IsNullOrWhiteSpace($ConfigFileBaseName)) {
    $AvailableConfigs = Get-ChildItem -Path $PSScriptRoot -Filter '*.ini'
    if ($AvailableConfigs.Count -gt 0) {
        Write-Host '=============== Azure AD Audit Tenant Selection Menu ==============='
        Write-Host ''
        $i = 0
        foreach ($config in $AvailableConfigs) {
            Write-Host "$($i) - $($config.BaseName)"
            $i++
        }
        Write-Host ''
        Write-Host 'Press "N" to manage configuration files.'
        Write-Host 'Press "Q" to quit.'
        $SelectedConfig = Read-Host "Please make a selection"
        if ($SelectedConfig -eq 'Q') {
            exit
        } elseif ($SelectedConfig -eq 'N') {
            $ConfigFileBaseName = Set-ConfigurationFile
            try {
                $LoadedConfig = Import-Clixml -Path ($AvailableConfigs | Where-Object -FilterScript {$_.BaseName -eq $ConfigFileBaseName}).FullName
            }
            catch {throw $_}
        }
        try {
            $LoadedConfig = Import-Clixml -Path $AvailableConfigs[$SelectedConfig].FullName
        }
        catch {throw $_}
    } else {
        $ConfigFileBaseName = Set-ConfigurationFile
        try {
            $LoadedConfig = Import-Clixml -Path ($AvailableConfigs | Where-Object -FilterScript {$_.BaseName -eq $ConfigFileBaseName}).FullName
        }
        catch {throw $_}
    }
} else {
    Write-LogFileEntry -Info "Loading specified config file: $ConfigFileBaseName"
    try {
        $LoadedConfig = Import-Clixml -Path ($AvailableConfigs | Where-Object -FilterScript {$_.BaseName -eq $ConfigFileBaseName}).FullName
        Write-LogFileEntry -Success "Loaded config for: $ConfigFileBaseName"
    }
    catch {
        Write-LogFileEntry -ErrorMessage "Failed loading config for: $ConfigFileBaseName" -ErrorRecord $_
        Exit
    }
}
#endregion Select config file

Write-LogFileEntry -Info "Trying to get a Graph API Access Token for tenant: $($LoadedConfig.TenantId)"
try {
    $GraphToken = Invoke-RestMethod -Method 'POST' -Uri "https://login.microsoftonline.com/$($LoadedConfig.TenantId)/oauth2/v2.0/token" -Body @{
        client_id     = $LoadedConfig.AppId
        client_secret = $LoadedConfig.Secret
        scope         = 'https://graph.microsoft.com/.default'
        grant_type    = 'client_credentials'
    } -ContentType 'application/x-www-form-urlencoded' -ErrorAction Stop | Select-Object -ExpandProperty 'access_token'
    Write-LogFileEntry -Success "Gathered a Graph API Access Token on tenant: $($LoadedConfig.TenantId)"
}
catch {
    Write-LogFileEntry -ErrorMessage "Failed getting Graph API Access Token on tenant: $($LoadedConfig.TenantId)" -ErrorRecord $_
    Exit
}

[Collections.ArrayList]$Indicators = @()
#endregion Init

#region Main
#region Gathering Azure AD Data
Write-LogFileEntry -Info 'Loading Tenant Information and Check Rules scripts.'
$Scriptblocks = @(
    (Get-ChildItem -Path "$PSScriptRoot\lib" -Filter 'TI*-*.ps1')
    (Get-ChildItem -Path "$PSScriptRoot\lib" -Filter 'CR*-*.ps1')
) | ForEach-Object -Process {
    (Get-Command $_.FullName).ScriptBlock
}

Write-LogFileEntry -Info "Start running scripts over target tenant: $($LoadedConfig.TenantId)"
try {
    $Outputs = Invoke-ParallelRunSpace -Scriptblock $Scriptblocks -Parameter @{
        GraphAPIAccessToken = $GraphToken
    } -ErrorAction Stop | Select-Object -ExpandProperty Result
    Write-LogFileEntry -Success 'Gathered scripts outputs'
}
catch {
    Write-LogFileEntry -ErrorMessage 'Failed gathering scripts outputs' -ErrorRecord $_
    Exit
}

$TenantInfoBasics = ($Outputs | Where-Object -FilterScript {$_.Id -eq 'TI0001'}).Result
$InitialDomain    = $TenantInfoBasics.Organization.verifiedDomains | Where-Object -FilterScript {$_.IsInitial -eq $true} | Select-Object -ExpandProperty Name
$OutputFilePath   = '{0}\Output\{1}-{2:yyyyMMdd_HHmm}' -f $PSScriptRoot, $InitialDomain, $Start
#endregion Gathering Azure AD Data

#region Gathering Reports Indicator History (XML Files)
$IndicatorsHistory = Get-ChildItem -Path "$PSScriptRoot\Output\" -Filter "$InitialDomain-*.xml" | ForEach-Object -Process {
    $StrDate = $_.BaseName.Split('-')[1]
    $Data = Import-Clixml -Path $_.FullName
    $Date = Get-Date -Year $StrDate.Substring(0,4) -Month $StrDate.Substring(4,2) -Day $StrDate.Substring(6,2) -Hour $StrDate.Substring(9,2) -Minute $StrDate.Substring(11,2) -Second 00
    $Data.Indicators | ForEach-Object -Process {
        @{
            Name  = $_.Name
            Score = $_.Score
            Date  = $Date
        }
    }
}
#endregion Gathering Reports Indicator History (XML Files)

#region Generating HTML and XML Output File
Write-LogFileEntry -Info 'Start generating HTML content and file'
New-PSHtmlHtml -lang 'en' -Content {
    New-PSHtmlHead -Content {
        New-PSHtmlMeta -charset 'utf-8'
        New-PSHtmlTitle -Content $ScriptTitle
        New-PSHtmlLink -rel 'stylesheet' -href 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css'
        New-PSHtmlLink -rel 'stylesheet' -href 'https://unpkg.com/bootstrap-table@1.20.2/dist/bootstrap-table.min.css'
        New-PSHtmlLink -rel 'stylesheet' -href 'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css'
        New-PSHtmlScript -src 'https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js'
        New-PSHtmlScript -src 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js'
        New-PSHtmlScript -src 'https://unpkg.com/bootstrap-table@1.20.2/dist/bootstrap-table.min.js'
        New-PSHtmlScript -src 'https://cdn.jsdelivr.net/npm/chart.js'
        New-PSHtmlStyle -Content @'
.form-control-dark {color: #fff; background-color: rgba(255, 255, 255, .1);}
.form-control-dark:focus {box-shadow: 0 0 0 3px rgba(255, 255, 255, .25);}          
.sidebar {position: fixed;top: 0;bottom: 0;left: 0;z-index: 100;padding: 48px 0 0;}
.dropdown-toggle { outline: 0; }
.accordion-body.bg-dark {color: white;}
.btn-toggle,.btn-toggle-nochild {padding: .25rem .5rem; font-weight: 600;}
.btn-toggle.btn-light::before {width: 1.25em; line-height: 0; content: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='rgba%280,0,0%29' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 14l6-6-6-6'/%3e%3c/svg%3e");}
.btn-toggle.btn-dark::before {width: 1.25em; line-height: 0; content: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='rgba%28255,255,255%29' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 14l6-6-6-6'/%3e%3c/svg%3e");}
.btn-toggle-nav a {padding: .1875rem .5rem; margin-top: .125rem; margin-left: 1.25rem;}
'@
        New-PSHtmlScript -lang 'javascript' -Content @'
function searchNavbar() {
    let input = document.getElementById('searchBar').value
    input=input.toLowerCase();
    let x = document.getElementsByClassName('navitem');
      
    for (i = 0; i < x.length; i++) { 
        if (!x[i].innerHTML.toLowerCase().includes(input)) {
            x[i].style.display="none";
        } else {
            x[i].style="";                 
        }
    }
}
'@
    }
    New-PSHtmlBody -Content {
        New-PSHtmlHeader -class 'navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 border-bottom' -Content {
            New-PSHtmldiv -class 'container-fluid' -Content {
                New-PSHtmlA -class 'navbar-brand' -href '#' -Content $ScriptTitle
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
                                New-PSHtmlLi -Content {
                                    New-PSHtmlA -Href 'https://getbootstrap.com/' -Content 'Bootstrap'
                                }
                                New-PSHtmlLi -Content {
                                    New-PSHtmlA -Href 'https://bootstrap-table.com/' -Content 'Bootstrap Table'
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        New-PSHtmlDiv -class 'row container-fluid' -style 'margin-top: 15px;' -Content {
            New-PSHtmlNav -class 'col-2 bg-light sidebar border-end' -Content {
                New-PSHtmlDiv -class 'position-sticky sidebar-sticky' -Content {
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
                        New-PSHtmlH5 -Content 'Tenant Informations'
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
                                    New-PSHtmlTd -Content '' #$TenantInfoBasics.OrgInfo
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
                                        New-PSHtmlBootstrapTable -TableId 'DNSDomainDetails' -Data $($TenantInfoBasics.Domains | Select-Object -Property Id,AuthenticationType,IsDefault,IsInitial,IsVerified,@{
                                            Name = 'SupportedServices'
                                            Expression = {
                                                $_.supportedServices -join ', '
                                            }
                                        }) -Searchable -Paged
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
                                foreach ($category in $Categories[0..5]) {
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
                                                        New-PSHtmlDiv -class 'offcanvas offcanvas-end bg-light' -style 'width: 25vw;' -id "offcanvas$($entry.Id)" -OtherAttributes @{
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
                                                                                New-PSHtmlTd -Content $entry.Version
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
                                                if ($null -ne $entry.Result.Data) {
                                                    New-PSHtmlDiv -class 'py-2' -Content {
                                                        New-PSHtmlH4 -Content 'Report Data'
                                                        New-PSHtmlP -Content 'Here is what has been found:'
                                                        New-PSHtmlBootstrapTable -TableId "$($entry.Id)table" -Data $entry.Result.Data -Searchable -Paged
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
/**
*  Light Switch
*/

(function () {
    let lightSwitch = document.getElementById('lightSwitch');
    if (!lightSwitch) {
        return;
    }

    /**
     * @function darkmode
     * @summary: changes the theme to 'dark mode' and save settings to local stroage.
     * Basically, replaces/toggles every CSS class that has '-light' class with '-dark'
     */
    function darkMode() {
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
            // add table-dark class to each table
            tables[i].classList.add('table-dark');
        }

        // set light switch input to true
        if (!lightSwitch.checked) {
            lightSwitch.checked = true;
        }
        localStorage.setItem('lightSwitch', 'dark');
    }

    /**
     * @function lightmode
     * @summary: changes the theme to 'light mode' and save settings to local stroage.
     */
    function lightMode() {
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

    /**
     * @function onToggleMode
     * @summary: the event handler attached to the switch. calling @darkMode or @lightMode depending on the checked state.
     */
    function onToggleMode() {
        if (lightSwitch.checked) {
            darkMode();
        } else {
            lightMode();
        }
    }

    function setup() {
        lightSwitch.addEventListener('change', onToggleMode);
        onToggleMode();
    }

    setup();
})();        
'@
    }
} | Out-File -FilePath "$OutputFilePath.html" -Encoding 'utf8' -Force

#Out XML File
Write-LogFileEntry -Info 'Start generating XML content and file'
@{
    Indicators = $Indicators
    RawData    = $Outputs
} | Export-Clixml -Path "$OutputFilePath.xml" -Depth 99 -Encoding UTF8 -Force
#endregion Generating HTML and XML Output File

#Write end message and open HTML File
Write-LogFileEntry -Info "Script took $(New-TimeSpan -Start $Start -End (Get-Date)) to run."
Write-LogFileEntry -Info 'Output files are available:'
Write-LogFileEntry -Info "`tHTML: $OutputFilePath.html"
Write-LogFileEntry -Info "`tXML : $OutputFilePath.xml"

if ($OpenHtml) {
    Start-Process -FilePath "$OutputFilePath.html"
}
#endregion Main