# Azure AD Configuration Report
Inspired from Semperis Purple Kngith and PingCastCloud Azure AD reports.

This script will help you report the current state of your Azure AD tenant configuration in details.

You only need PowerShell 3.0 and access to Microsoft Graph API endpoints (https).

The script has been designed and written to be used as a framework. You can configure your own Check Rules using the template PowerShell file in the Lib folder.
Every Check Rules can be ran as standalone script if you want to use them seperatly.

The script generate two output file:
- HTML, using home made module to write HTML with PowerShell, which will highlight configuration pain points
- XML, using Export-CliXml, that will allow you to integrate output data to any other tool you want

# Prerequisites
In case you use the script to Generate the Azure AD Application Registration and API Permissions, the AzureAD PowerShell module is required.
To install the module: Install-Module -Name AzureAD

# To-do
- Generate Line Chart to show progression in the Indicators using previous XML files