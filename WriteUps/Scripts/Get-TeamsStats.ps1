Param
(
    [parameter(Mandatory=$true)]
    [ValidateSet('Public','GCC','GCCHIGH','DOD')]
    [string]
    $EnvironmentName,

    [parameter(Mandatory=$true)]
    [string]
    $OutputCsvFilePath
)

if($EnvironmentName -like 'Public'){
    Connect-MicrosoftTeams
}
elseif($EnvironmentName -like 'GCC'){
    Connect-MicrosoftTeams
}
elseif($EnvironmentName -like 'GCCHIGH'){
    Connect-MicrosoftTeams -TeamsEnvironmentName 'TeamsGCCH'
}
elseif($EnvironmentName -like 'DOD'){
    Connect-MicrosoftTeams -TeamsEnvironmentName 'TeamsDOD'
}

$hash = @{}

$allTeams = Get-Team

foreach($team in $allTeams){
    $channels = Get-TeamChannel -GroupId $team.GroupId

    foreach($channel in $channels){
        $value = [PSCustomObject]@{
                GroupId            = $team.GroupId
                TeamName           = $team.DisplayName
                ChannelId          = $channel.Id
                ChannelName        = $channel.DisplayName
                ChannelDescription = $channel.Description
                Visibility         = $team.Visibility
                Archived           = $team.Archived
            }

            $hash.Add($channel.Id, $value)
    }
}

$hash.Values | Export-Csv -Path $OutputCsvFilePath -NoTypeInformation