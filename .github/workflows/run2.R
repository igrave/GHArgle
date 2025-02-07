remotes::install_github("igrave/gargle")
library(gargle)
credentials_github_actions(
    project_id = 'helpful-range-376621',
  workload_identity_provider = 'projects/1073903696751/locations/global/workloadIdentityPools/github/providers/my-repo',
  service_account = 'ladder-testing-account@helpful-range-376621.iam.gserviceaccount.com',
  lifetime = '3600s',
  scopes = "https://www.googleapis.com/auth/drive.file",
)
