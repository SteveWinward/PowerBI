# This script will create a subfolder 'downloads' in the current working directory
# all downloads will be saved to this subfolder

$downloadFolder = Join-Path $PSScriptRoot 'downloads'

if(-not (Test-Path $downloadFolder)){
    Write-Output "$downloadFolder does not exist"
    Write-Output "Creating $downloadFolder"
    
    New-Item -Path $downloadFolder -ItemType Directory
}

# Download the list of all Power BI Visuals from the search api
$searchRequest = 'https://store.office.com/api/addins/search?ad=US&apiversion=1.0&client=Any_PowerBI&top=500'


$json = Invoke-WebRequest $searchRequest |
    ConvertFrom-Json 

$results = $json.Values

# loop over all results
$results | foreach {
    # Download the manifest xml file
    [xml]$xml = (New-Object System.Net.WebClient).DownloadString($_.ManifestUrl)

    # find the download url for the pbiviz file
    $fileUrl = $xml.OfficeApp.DefaultSettings.SourceLocation.DefaultValue

    # parse the visual file name
    $visualName = $fileUrl.split('/')[-1]

    $visualName

    # create the destination path
    $destFilePath = Join-Path $downloadFolder $visualName

    # download and save the pbiviz file to the downloads subfolder
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($fileUrl, $destFilePath)
}