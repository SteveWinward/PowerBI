# Power BI, PowerShell and Azure Function Automation

I published a video on YouTube that outlines how you can use Service Principal authentication to connect to Power BI with PowerShell.  I then take a script and setup an Azure Function that runs PowerShell to automate this.  The linkt to the video is below,

https://youtu.be/l_5bTH_Ipoo

The PowerShell Script I used for this demo is inline below,

```
using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

$appId = $env:APP_ID
$tenantId = $env:APP_TENANT_ID
$clientCert = $env:CLIENT_CERT
$secret = $env:APP_SECRET

# Using client cert auth
Connect-PowerBIServiceAccount -ServicePrincipal -Tenant $tenantId -CertificateThumbprint $clientCert -ApplicationId $appId

# Using app secret auth
$password = ConvertTo-SecureString $secret -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($appId, $password)

Connect-PowerBIServiceAccount -ServicePrincipal -Tenant $tenantId -Credential $credential

$groups = Get-PowerBIGroup -Scope Organization

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $groups
})

# output to the blob file
Push-OutputBinding -Name outputBlob -Value $groups -Clobber
```
Make sure to configure the following application settings in your Azure Function app,

```
    "CLIENT_CERT": "<ACTUAL_CERT_THUMBPRINT>",  // IF USING CLIENT CERT AUTH
    "WEBSITE_LOAD_CERTIFICATES": "<ACTUAL_CERT_THUMBPRINT>", // TELLS AZURE FUNCTION TO LOAD THE CLIENT CERT
    "APP_ID": "<AAD_APPLICATION_ID>",
    "APP_TENANT_ID": "<AAD_TENANT_ID>",
    "APP_SECRET": "<AAD_APPLICATION_SECRET>", // IF USING APP SECRET AUTHENTICATION
```
