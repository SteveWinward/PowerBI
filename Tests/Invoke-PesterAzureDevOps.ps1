# Used for Azure DevOps unit test results
# To run locally, simply just run Invoke-Pester, no need to run this script
# https://github.com/devopsdina/ado-pipelines-demo-win/blob/master/Invoke-PesterAzureDevOps.ps1

# Install Pester
Write-Host "Installing Pester Module"

try{
    Install-Module -Name Pester -Force -SkipPublisherCheck
}
catch{
    Install-Module -Name Pester -Force
}

Write-Host ""

# Import the Pester Module
Write-Host "Importing Pester Module"
Import-Module Pester
Write-Host ""

$outputFile = ".\TEST-RESULTS.xml"

Write-Host "Running Pester"
Invoke-Pester -OutputFile $outputFile -OutputFormat ".\Tests\NUnitXml"
Write-Host ""

Write-Host "Outputting file structure for debugging"
Get-ChildItem -Recurse