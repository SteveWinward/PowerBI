# Power BI Audit Log Analysis

In order to view and analyze the Power BI audit logs in O365, you first need to make sure auditing is enabled for your O365 tenant.

https://docs.microsoft.com/en-us/power-bi/service-admin-auditing#use-the-audit-log

## Accessing Audit Logs
You need to either be a O365 Global Admin or you need to be assigned the View-Only Audit Logs role in Exchange Online.  More details in the link below,

https://docs.microsoft.com/en-us/power-bi/service-admin-auditing#audit-log-requirements

Each O365 service has different guarantees around how quickly events show up in the audit logs.  Power BI events in the service today (3/25/2020) will show up within 30 minutes of when the events occur.

https://docs.microsoft.com/en-us/microsoft-365/compliance/search-the-audit-log-in-security-and-compliance?view=o365-worldwide

## Analyzing Audits via the Unified Audit Log UI
The O365 Audit Logs URL is different based on the cloud environment you are using,

|Environment|URL|
|---|---|
|Commerical|https://protection.office.com/unifiedauditlog|
|GCC|https://protection.office.com/unifiedauditlog|
|GCC High|https://scc.office365.us/unifiedauditlog|

If you go to the link above for your environment, you can manually search for Power BI events.  

![Power BI Activities](Images/power-bi-audit-logs-activities.png)

If you want to setup an automated alert anytime one of your filters triggers, you can create a new alert policy in the UI,

![Alert Policies](Images/power-bi-audit-logs-new-alert-policy.JPG)

User information will show up with a ObjectUserID.  If you want to lookup the user information, go to the Azure portal,

|Environment|URL|
|---|---|
|Commercial|https://portal.azure.com|
|GCC|https://portal.azure.com|
|GCC High / GCC DoD|https://portal.azure.us|

Once in the Azure Portal, go to the Azure Active Directory blade.

Then go to Users.  Then search for the ObjectUserID in the search box.  Make sure to change the Search Attributes drop down to "Object ID (exact match).

![Azure Portal Screenshot](Images/power-bi-audit-logs-userobjectid-lookup-azure.JPG)

## PowerShell
You can also search the audit logs via PowerShell.  You need one module installed to do this.

````
# Run this in an Administrator session of PowerShell
Install-Module -Name AzureAD
````

If it was already installed, its always a good idea to update the Module
````
Update-Module -Name AzureAD
````

To connect to O365 you need to use the Exchange Online remote PowerShell module,
````
# Set the user credentials
$userCredential = Get-Credential

# Set the Environment URL (only use one of these for your actual environment)

# Commercial / GCC
$environmentUrl = "https://outlook.office365.com/powershell-liveid/"

# GCC High
$environmentUrl = "https://outlook.office365.us/powershell-liveid"

# GCC DoD
$environmentUrl = "https://webmail.apps.mil/powershell-liveid/"

# Setup the session
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $environmentUrl -Credential $UserCredential -Authentication Basic -AllowRedirection

# Import the session
Import-PSSession $Session -DisableNameChecking
````

Now you can use the Search-UnifiedAuditLog commandlet to your O365 environment and filter to all Power BI activities

````
# Note: RecordType 20 is the filter for Power BI activities
$EndDate = (Get-Date).ToString("MM/dd/yyyy")
$StartDate = (Get-Date).AddDays(-5).ToString("MM/dd/yyyy")

Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -RecordType 20 -Formatted
````

## Filtering for Access Changes
A common question customers want to answer is have any of my Power BI Workspaces access changed recently?  

### Classic Workspaces
Classic workspaces are tied directly to an O365 group for access.  As a result, if you want to monitor access changes to a classic workspace, you need to monitor the activity events around an O365 group which can be found in the Azure AD audit events.

[Azure AD Audit Event Types](https://docs.microsoft.com/en-us/microsoft-365/compliance/search-the-audit-log-in-security-and-compliance?view=o365-worldwide#azure-ad-group-administration-activities)

For example, if you wanted to analyze all of the events around users being added to a group called "Finance Team" over the last 5 days you could run the following PowerShell command,

````
$EndDate = (Get-Date).ToString("MM/dd/yyyy")
$StartDate = (Get-Date).AddDays(-5).ToString("MM/dd/yyyy")

Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -RecordType 8 -Formatted -FreeText "Finance Team" -Operations "Add member to group"
````

### V2 Workspaces
The newer workspaces do not require an O365 group to be created.  As a result, you can add users, distribution groups, security groups and O365 groups to roles in V2 workspaces.  

[New Workspaces Docs](https://docs.microsoft.com/en-us/power-bi/service-new-workspaces)

The following activities are available for auditing these workspaces,

|Activity Type|Activity Description|
|---|---|
|UpdateFolder|Updated Power BI folder|
|UpdateFolderAccess|Updated Power BI folder access|
|CreateFolder|Created Power BI folder|
|DeleteFolder|Deleted Power BI folder|

There are also the same types of activity types for Apps (ie when you publish a workspace as an app)

|Activity Type|Activity Description|
|---|---|
|CreateApp|Created Power BI app|
|UpdateApp|Updated Power BI app|

Another interesting activty type is GetGroupsAsAdmin.  This will tell you when a Power BI Admin is using the Power BI PowerShell modules to list all of the workspaces in the tenant.

|Activity Type|Activity Description|
|---|---|
|GetGroupsAsAdmin|Lists all Workspaces for an Admin regardless of their actual Workspace membership|

If you want to view recent Workspace access changes you can query via PowerShell with this sample example,

````
$EndDate = (Get-Date).ToString("MM/dd/yyyy")
$StartDate = (Get-Date).AddDays(-5).ToString("MM/dd/yyyy")

Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -RecordType 20 -Operations "Update*Access" -Formatted
````

Note that today (3/27/2020) if a Power BI Admin adds themselves to a workspace via the Admin Portal in Power BI, the operation type will show up as "UpdateWorkspaceAccess", even if its a V2 workspace.  This is why the filter in the previous example uses "Update*Access" because it includes both UpdateWorkspaceAccess and UpdateFolderAccess.  In this example, you would also see an event for "GetGroupsAsAdmin" when they viewed the workspaces via the Admin Portal.  To view all of these events together you could use the following script,

````
$EndDate = (Get-Date).ToString("MM/dd/yyyy")
$StartDate = (Get-Date).AddDays(-5).ToString("MM/dd/yyyy")

Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -RecordType 20 -Operations "Update*Access", "*Admin*" -Formatted
````

You can also specify a Workspace ID if you want to filter on a specific workspace.  To figure out what the Workspace ID is for a Workspace, go to the Workspace in a browser and copy the GUID in the URL (https://<power_bi_service>/groups/<Workspace ID>).

````
$EndDate = (Get-Date).ToString("MM/dd/yyyy")
$StartDate = (Get-Date).AddDays(-5).ToString("MM/dd/yyyy")

Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -RecordType 20 -FreeText "0c6e1347-d325-4285-b944-84513db16887" -Formatted
````

This would yield sample results like below,

````
RunspaceId   : cb1ee2dc-983c-446c-9cfa-4267175dea42
RecordType   : PowerBIAudit
CreationDate : 3/3/2020 2:58:11 AM
UserIds      : john@contoso.onmicrosoft.com
Operations   : UpdateFolderAccess
AuditData    : {
                 "Id": "e1e9ae76-0266-4002-8cfa-70fd2d23e59c",
                 "RecordType": "PowerBIAudit",
                 "CreationTime": "2020-03-03T02:58:11",
                 "Operation": "UpdateFolderAccess",
                 "OrganizationId": "79d8c44b-ee77-444b-bd81-f855d8040a69",
                 "UserType": "Regular",
                 "UserKey": "10030000A8DBA471",
                 "Workload": "PowerBI",
                 "UserId": "john@contoso.onmicrosoft.com",
                 "ClientIP": "95.20.144.123",
                 "UserAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)
               Chrome/80.0.3987.122 Safari/537.36",
                 "Activity": "UpdateFolderAccess",
                 "IsSuccess": true,
                 "FolderObjectId": "c3f9c058-dc84-409c-b050-c97e567b4bb6",
                 "FolderDisplayName": "Johns's Test V2 Workspace",
                 "FolderAccessRequests": [
                   {
                     "RolePermissions": "ReadReshareExplore",
                     "UserObjectId": "14fa6fa9-dfd3-4b0f-ad79-29309e3f37b2"
                   }
                 ],
                 "RequestId": "4c911fda-9269-e4af-2445-a4b1c4a60d41",
                 "ActivityId": "e54052a9-de1a-4553-8c07-0bb8bcae38aa"
               }
ResultIndex  : 2
ResultCount  : 2
Identity     : e1e9ae76-0266-4002-8cfa-70fd2d23e59c
IsValid      : True
ObjectState  : Unchanged
````

If you look at the FolderAccessRequests section you can see the UserObjectId associated with the access granted.  

Now if you wanted to explore details around this user, you can use the AzureAD PowerShell module to view the users information,

````
# First you need to connect to AzureAD
# Commercial or GCC Mod
Connect-AzureAD

# GCC High / GCC DoD
Connect-AzureAD -AzureEnvironmentName AzureUSGovernment

# Query the Azure AD for the UserObjectID
Get-AzureADUser -ObjectId 14fa6fa9-dfd3-4b0f-ad79-29309e3f37b2
````

Now you can view the details of the AzureAD properties for the user,

````
ObjectId                             DisplayName   UserPrincipalName                       UserType
--------                             -----------   -----------------                       --------
14fa6fa9-dfd3-4b0f-ad79-29309e3f37b2 John Doe      john@contoso.onmicrosoft.com            Member
````

### Grouping Activity by Users
An example of grouping Power BI activity by users is below using the PowerShell GroupBy function,

````
# Note: RecordType 20 is the filter for Power BI activities
$EndDate = (Get-Date).ToString("MM/dd/yyyy")
$StartDate = (Get-Date).AddDays(-5).ToString("MM/dd/yyyy")

Search-UnifiedAuditLog -StartDate $StartDate -EndDate $EndDate -RecordType 20 | Group-Object -Property UserIds, Operations| Export-Csv output.csv
````