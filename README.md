# Introduction 

This repo contains PowerShell Command to be used with Fabric Admin privileges in order to extract key insights for Analytics Governance -

The scripts extract key logs using the [ MicrosoftPowerBIMgmt  Cmdlet module](https://learn.microsoft.com/en-us/powershell/power-bi/overview?view=powerbi-ps)
Additional R scripts to generate a high level powerpoint presentations of the insights.

It builds on https://learn.microsoft.com/en-us/power-bi/guidance/admin-activity-log analysising all type of [Operations](https://learn.microsoft.com/en-us/fabric/admin/operation-list)

See also - https://powerbi.microsoft.com/en-us/blog/announcing-apis-and-powershell-cmdlets-for-power-bi-administrators/ 

Extra example here: https://github.com/TedData/teddata.github.io/blob/main/_posts/2023-11-03-PowerBIServiceDataExportScript.md  & https://github.com/BrettP76/Insight-Quest-Examples/tree/master/Common%20PBI%20Admin%20Scripts


# Getting Started

1.	Installation process - need administrator privileges on the computer and Fabric admin level access for the user
2.	Software dependencies: user MicrosoftPowerBIMgmt module  
 

# Extract 


Open PowerShell ISE with Win + X or start a shell and run



## Extract all Users from Active Directory


```
# Install the Microsoft Graph PowerShell SDK
Install-Module Microsoft.Graph -Scope CurrentUser

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.Read.All"

#To test if the cmdlet is working you can simply get all users from your Azure Active Directory with the following cmdlet:
#Get-MgUser -All

# Export users to a CSV file
Get-MgUser -All -Property  id, userType, userPrincipalName, displayName, surname, givenName,  jobTitle, department, accountEnabled, usageLocation, creationType, directorySynced, createdDateTime   | select  id, userType, userPrincipalName, displayName, surname, givenName,  jobTitle, department, accountEnabled, usageLocation, creationType, directorySynced, createdDateTime | Export-CSV -nti "C:\pbi\data-raw\AADUsers.csv" 


# Disconnect from Microsoft Graph
#Disconnect-MgGraph
```

## Extract Logs

First ensure to have activitate the [Privilege Identity Management](https://portal.azure.com/?feature.msaljs=true#view/Microsoft_Azure_PIMCommon/ActivationMenuBlade/~/aadmigratedroles/provider/aadroles)

Clone this repo to `C:\pbi`
cd in the repo to the `powershell` folder

First you need to log in as an admin...

```
runas /user:administrator powershell

```

```
 cd C:\pbi\powershell
 ## install the module PowerBI PowerShell SDK
.\installmodule.ps1

## log in with admin account
Connect-PowerBIServiceAccount

## List all capacities

Get-PowerBICapacity -Scope Organization -ShowEncryptionKey | ConvertTo-Json -Depth 10 | Out-File -FilePath C:\pbi\data-raw\Capacity.json -Encoding UTF8

## Extract a description of all content
Get-PowerBIWorkspace -Scope Organization -All -Include All | ConvertTo-Json -Depth 10 | Out-File -FilePath C:\pbi\data-raw\WorkSpace.json -Encoding UTF8

## Extract all Events
## This use the https://learn.microsoft.com/en-us/power-bi/enterprise/service-admin-auditing#get-powerbiactivityevent-cmdlet 
.\getpbievent.ps1

```


# Build and Test

Once you extract the data, use the Rmd file to generate the presentations
Note that you will also need the extract from PRISM to generate the presentations



# Contribute

Do not hesitate to submit code improvement
