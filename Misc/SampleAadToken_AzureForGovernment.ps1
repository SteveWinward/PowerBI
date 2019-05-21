# This requries you to create an AAD Application ahead of time.

$tenantname     = "<INSERT_ACTUAL_TENANT_GUID>"
$ClientID       = "<INSERT_ACTUAL_CLIENT_ID>" 
$ClientSecret   = "<INSERT_ACTUAL_CLIENT_SECRET>"

$loginURL       = "https://login.microsoftonline.us"  
$resource       = "https://graph.microsoft.us" 

$body       = @{grant_type="client_credentials";resource=$resource;client_id=$ClientID;client_secret=$ClientSecret} 
$oauth      = Invoke-RestMethod -Method POST -Uri $loginURL/$tenantname/oauth2/token?api-version=1.0 -Body $body 

$oauth.access_token

# Sample call to list all users in the tenant
$graphOperationUrl = "https://graph.microsoft.us/v1.0/users"
$headerParams = @{'Authorization'="$($oauth.token_type) $($oauth.access_token)"}
$response = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $graphOperationUrl -Method GET) 

$response