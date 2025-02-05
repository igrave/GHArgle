library(httr)

id_token_url <- Sys.getenv("ACTIONS_ID_TOKEN_REQUEST_URL")
id_token_request_token <- Sys.getenv("ACTIONS_ID_TOKEN_REQUEST_TOKEN")

project_id <- 'helpful-range-376621'
workload_identity_provider <- 'projects/1073903696751/locations/global/workloadIdentityPools/github/providers/my-repo'
token_format <- 'access_token'
service_account <- 'ladder-testing-account@helpful-range-376621.iam.gserviceaccount.com'
access_token_lifetime <- '300s' # optional, default: '3600s' (1 hour)
access_token_scopes <-  'https://www.googleapis.com/auth/drive.file'
create_credentials_file <- TRUE


oidcTokenAudience <- paste0("https://iam.googleapis.com/", workload_identity_provider)

# getIDToken(oidcTokenAudience) --------------------
oidcToken <- httr::GET(
    id_token_url,
    add_headers(Authorization = paste0("Bearer ", id_token_request_token)),
    params = list(audience = oidcTokenAudience)
)
oidcToken