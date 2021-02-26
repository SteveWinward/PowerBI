# Power BI PowerShell Analysis

A common question that comes up is "How many people have published reports in our Power BI service?".  There are a few different ways to go about this.  Below is how you can use a PowerShell script to loop through all of the workspaces in Power BI, and then loop through all of the datasets to find the creator of each dataset.  This gives you insight into anyone that has created at least one report in the Power BI Service.

You do need to be a Power BI Admin to run this script properly.

## Sample PowerShell Script

Below is a link to a sample script to loop over all workspaces in a Power BI tenant and then report on a list of all authors of datasets.

[Sample Script](Scripts/Get-PowerBIDatasetReportForTenant.ps1)

You can run this script as below,

````
# EnvironmentName options => Public, USGov, USGovHigh, USGovMil
.\Get-PowerBIDatasetReportForTenant.ps1 -EnvironmentName USGovHigh
````

You will get prompted to sign in with your O365 AAD credentials.  

You can also export the result set to a CSV with the following script

````
# EnvironmentName options => Public, USGov, USGovHigh, USGovMil
.\Get-PowerBIDatasetReportForTenant.ps1 -EnvironmentName USGovHigh | Export-Csv -Path output.csv -NoTypeInformation
````
