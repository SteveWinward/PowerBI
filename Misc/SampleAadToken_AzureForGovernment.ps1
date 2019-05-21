# This requries you to create an AAD Application ahead of time.

$tenantname     = "<INSERT_ACTUAL_TENANT_GUID>"
$ClientID       = "<INSERT_ACTUAL_CLIENT_ID>" #This is the Applicaiton ID of the AAD App
$ClientSecret   = "<INSERT_ACTUAL_CLIENT_SECRET>" #This is the client secret you create for the AAD App 

# This is the Azure for Government login URL
$loginURL       = "https://login.microsoftonline.us"

# This is the Grap API endpoint for Azure for Government
$resource       = "https://graph.microsoft.us" 

# Constructs an HTTP POST request to get an OAuth token from AAD
$body       = @{grant_type="client_credentials";resource=$resource;client_id=$ClientID;client_secret=$ClientSecret} 
$oauth      = Invoke-RestMethod -Method POST -Uri $loginURL/$tenantname/oauth2/token?api-version=1.0 -Body $body 

# Outputs the JWT token for debugging
$oauth.access_token

# Sample call to list all users in the tenant
# This requires application permissions to the User.ReadBasic.All (Graph API)
$graphOperationUrl = "https://graph.microsoft.us/v1.0/users"
$headerParams = @{'Authorization'="$($oauth.token_type) $($oauth.access_token)"}
$response = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $graphOperationUrl -Method GET) 

# Outputs the Graph API response for debugging
$response