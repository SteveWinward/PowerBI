# Used for Azure DevOps unit test results
# To run locally, simply just run Invoke-Pester, no need to run this script
# https://github.com/devopsdina/ado-pipelines-demo-win/blob/master/Invoke-PesterAzureDevOps.ps1

Import-Module Pester

$outputFile = ".\TEST-RESULTS.xml"

Invoke-Pester -OutputFile $outputFile -OutputFormat NUnitXml