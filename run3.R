library(gargle)
library(ladder)
options(gargle_verbosity = "debug")


ladder::ladder_auth_gha_workflow(
    project_id = 'helpful-range-376621', 
    workload_identity_provider = 'projects/1073903696751/locations/global/workloadIdentityPools/github/providers/my-repo',
    service_account = 'ladder-testing-account@helpful-range-376621.iam.gserviceaccount.com',
    lifetime = '3600s',
    scopes = 'https://www.googleapis.com/auth/drive.file'
)

ladder::get_slide_ids("1Bu6ZD0mev_jYpLi-rbJnhl-X3xezY6i4cUPQBubJrEg")



