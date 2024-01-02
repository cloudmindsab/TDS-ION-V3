### Get oAuth Token from ION Portal
$url = 'https://api-platform.url'
$refreshToken = "R#E#F#R#E#S#H#T#O#K#E#N" ### GET FIrst Refresh with TTL FROM PORTAL
$refreshTokenParams = @{ 
    grant_type    = "refresh_token"
    redirect_url  = 'https://localhost/'
    refresh_token = $refreshToken
}

$tokenResponse = Invoke-RestMethod -Method POST -Uri "$url/oauth/token" -Body $refreshTokenParams

$accessToken = $tokenResponse.access_token          ### SAVE FOR OTHER REQUESTS
$tokenType = $tokenResponse.token_type              ### SAVE FOR OTHER REQUESTS
$newRefreshToken = $tokenResponse.refresh_token     ### SAVE FOR NEXT OATH REQUEST


## Initiate Request
$accountId = 'XXXXXXXX'  ### ACCOUNT ID IS STATED IN ACCOUNT INFORMATION
$pageSize = '1000'
$bearerAuthValue = "$tokenType $accessToken"
$headers = @{
    Authorization = $bearerAuthValue
}

$cresponse = Invoke-RestMethod "$url/api/v3/accounts/$accountId/customers?pageSize=$pageSize" -Method 'GET' -Headers $headers
$cresponse | ConvertTo-Json

$cresponse.customers        ### STEP INTO THE DATA

### INTERACT WITH THE DATA
foreach ($customer in $cresponse.customers ) {

}