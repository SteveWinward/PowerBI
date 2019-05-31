Get-ChildItem

Get-ChildItem -Path .\downloads -Filter *.pbiviz -Recurse      

$pbiVizFileCount = (Get-ChildItem -Path .\downloads -Filter *.pbiviz -Recurse).Count

Write-Output "Found $pbiVizFileCount pbiviz files in the downloads folder"

$pbiVizFilesExist = $pbiVizFileCount -gt 0

# if the folder does not contain a pbiviz file, throw an exception
if(-not $pbiVizFilesExist){ throw "No pbiviz files were downloaded" }