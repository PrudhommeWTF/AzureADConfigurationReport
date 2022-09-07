# Azure AD Configuration Report
This script will help you report the current state of your Azure AD tenant configuration in details.

You only need PowerShell 5.1 and access to Microsoft Graph API.

Current version does not include automation to generate the Azure App Registration and set the API Permissions required for the audit.

# Prerequisites
In case you use the script to Generate the Azure AD Application Registration and API Permissions, the AzureAD PowerShell module is required.
To install the module: Install-Module -Name AzureAD

# To-do
- Generate Line Chart to show progression in the Indicators using previous XML files