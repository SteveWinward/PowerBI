# Created by Steve Winward
#
# This script will download all Power BI visuals from the marketplace and save them
# to a downloads subfolder in the current working directory.
# 
# You can optionally specify the -CertifiedOnly switch to only download visuals
# that have gone through the certification process.
#
param (
    [switch]$CertifiedOnly = $false
)

$downloadFolder = Join-Path $PSScriptRoot 'downloads'

# Create the downloads folder if it doesn't already exist
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
    # if the CertifiedOnly switch was specified, skip any visuals that are not certified
    if($CertifiedOnly){
        $containsCertified = $_.Categories | where {$_.Id -eq 'Power BI Certified'}

        if($containsCertified -eq $null){
            return
        }
    }

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