Param
(
    [parameter(Mandatory=$true)]
    [ValidateSet('Public','USGov','USGovHigh','USGovMil')]
    [string]
    $EnvironmentName
)

$result = Login-PowerBI -Environment $EnvironmentName

$allGroups = Get-PowerBIGroup -Include Datasets -Scope Organization

$hash = @{}

$allGroups | foreach{
    $workspaceId = $_.Id
    $workspaceName = $_.Name
    $_.Datasets | foreach {
        $uniqueId = "" + $workspaceId + "-" + $_.ConfiguredBy

        if(-not($hash.ContainsKey($uniqueId))){
            $value = [PSCustomObject]@{
                WorkspaceId = $workspaceId
                ConfiguredBy     = $_.ConfiguredBy
                WorkspaceName = $workspaceName
            }
            $hash.Add($uniqueId, $value)
        }
    }    
}

$hash.Values