$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$scriptPath = "$here\..\Misc\VisualsBulkDownloadTool.ps1"

Describe "VisualsBulkDownloadTool" {
    It "Downloads MicrosoftOnly and CertifiedOnly pbiviz files" {
        . $scriptPath -MicrosoftOnly -CertifiedOnly
        
        Get-ChildItem -Path .\downloads -Filter *.pbiviz -Recurse      

        $pbiVizFileCount = (Get-ChildItem -Path .\downloads -Filter *.pbiviz -Recurse).Count

        Write-Output "Found $pbiVizFileCount pbiviz files in the downloads folder"

        # if the folder does not contain a pbiviz file, throw an exception
        $pbiVizFileCount | Should -BeGreaterThan 0
    }

    AfterEach {
        # Remove the downloads folder after each run
        Remove-Item .\downloads\ -Force -Recurse
    }
}