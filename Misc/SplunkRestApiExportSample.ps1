# Calls the Splunk REST API's Export endpoint to return search results

# Replace the actual Splunk JWT Token here,
$token = '<INSERT_TOKEN_HERE>'

# The endpoint will be different based on your Splunk instance
$exportUrl = 'https://SplunkServerDefaultCert:8089/services/search/jobs/export?'
$output_mode = 'csv'
$search = 'search source="tutorialdata.zip:*" clientip="87.194.216.51" | stats count by host'

# Constructs the Request URL 
$requestUrl = $exportUrl + 'output_mode=' + $output_mode + '&search=' + $search

# Add the Token to the Authorization header
$Headers = @{}
$Headers.Add('Authorization', 'Bearer ' + $token)

# Call the REST endpoint
Invoke-WebRequest -Uri $requestUrl -Headers $Headers -Verbose