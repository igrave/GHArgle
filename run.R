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
universe <- "googleapis.com"

oidcTokenAudience <- paste0("https://iam.googleapis.com/", workload_identity_provider)

# getIDToken(oidcTokenAudience) --------------------
oidcToken <- httr::GET(
    id_token_url,
    add_headers(Authorization = paste0("Bearer ", id_token_request_token)),
    query = list(audience = oidcTokenAudience)
)
oidcTokenString <- content(oidcToken)$value
nchar(oidcTokenString)
substr(oidcTokenString, 1, 5)
print(oidcTokenString)
str(oidcTokenString)
# get authtoken -----------------

# client = new WorkloadIdentityFederationClient({
#         logger: logger,
#         universe: universe,
#         requestReason: requestReason,

#         githubOIDCToken: oidcToken,
#         githubOIDCTokenRequestURL: oidcTokenRequestURL,
#         githubOIDCTokenRequestToken: oidcTokenRequestToken,
#         githubOIDCTokenAudience: oidcTokenAudience,
#         workloadIdentityProviderName: workloadIdentityProvider,
#         serviceAccount: serviceAccount,
#       })
#
##[debug]WorkloadIdentityFederationClient.getToken: Built request, {
##[debug]  "method": "POST",
##[debug]  "path": "https://sts.googleapis.com/v1/token",
##[debug]  "headers": {},
##[debug]  "body": {
##[debug]    "audience": "//iam.googleapis.com/projects/1073903696751/locations/global/workloadIdentityPools/github/providers/my-repo",
##[debug]    "grantType": "urn:ietf:params:oauth:grant-type:token-exchange",
##[debug]    "requestedTokenType": "urn:ietf:params:oauth:token-type:access_token",
##[debug]    "scope": "https://www.googleapis.com/auth/cloud-platform",
##[debug]    "subjectTokenType": "urn:ietf:params:oauth:token-type:jwt",
##[debug]    "subjectToken": "***"
##[debug]  }
##[debug]}

make_endpoints <- function(universe) {
    endpoints <- c(
     iam = "https://iam.{universe}/v1",
     iamcredentials = "https://iamcredentials.{universe}/v1",
     oauth2 = "https://oauth2.{universe}",
     sts = "https://sts.{universe}/v1",
     www = "https://www.{universe}"
    )
    sub("{universe}", universe, endpoints, fixed = TRUE)
}
#   protected readonly _endpoints = {
#     iam: 'https://iam.{universe}/v1',
#     iamcredentials: 'https://iamcredentials.{universe}/v1',
#     oauth2: 'https://oauth2.{universe}',
#     sts: 'https://sts.{universe}/v1',
#     www: 'https://www.{universe}',
#   };
endpoints <- make_endpoints(universe)

    #   audience: this.#audience,
    #   grantType: `urn:ietf:params:oauth:grant-type:token-exchange`,
    #   requestedTokenType: `urn:ietf:params:oauth:token-type:access_token`,
    #   scope: `${this._endpoints.www}/auth/cloud-platform`,
    #   subjectTokenType: `urn:ietf:params:oauth:token-type:jwt`,
    #   subjectToken: this.#githubOIDCToken,

authtoken <- httr::POST(
    url = paste0(endpoints[["sts"]], "/token"),
    body = list(
        audience = paste0("//", parse_url(oidcTokenAudience)$hostname, "/", workload_identity_provider),
        grantType = "urn:ietf:params:oauth:grant-type:token-exchange",
        requestedTokenType = "urn:ietf:params:oauth:token-type:access_token",
        scope = paste0(endpoints[["www"]], "/auth/cloud-platform"),
        subjectTokenType = "urn:ietf:params:oauth:token-type:jwt",
        subjectToken = oidcTokenString

    )
)
authtoken
content(authtoken)