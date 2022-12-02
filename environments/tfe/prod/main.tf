module "prod" {
  source                      = "../../../modules/tfe"
  workspace_name              = "auto-s3-prod"
  workspace_organization_name = "curry-org"
}
