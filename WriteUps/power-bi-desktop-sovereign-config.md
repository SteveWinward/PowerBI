# Power BI Destkop Registry Setting for Sovereign Clouds
Power BI Desktop uses a global discovery endpoint to route users to the correct sovereign cloud environments for customers in our US Government clouds.  If you want to bypass using this global discovery endpoint, you can use the following registry key settings,

GCC =>
````
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Power BI]
"PowerBIDiscoveryUrl"="https://api.powerbigov.us"

[HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Policies\Microsoft\Microsoft Power BI]
"PowerBIDiscoveryUrl"="https://api.powerbigov.us"
````

GCC High =>
````
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Power BI]
"PowerBIDiscoveryUrl"="https://api.high.powerbigov.us"

[HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Policies\Microsoft\Microsoft Power BI]
"PowerBIDiscoveryUrl"="https://api.high.powerbigov.us"
````

DOD =>
````
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Power BI]
"PowerBIDiscoveryUrl"="https://api.mil.powerbigov.us"

[HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Policies\Microsoft\Microsoft Power BI]
"PowerBIDiscoveryUrl"="https://api.mil.powerbigov.us"
````


