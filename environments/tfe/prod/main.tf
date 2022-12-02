module "prod" {
  source                      = "../../../modules/tfe"
  workspace_name              = "auto-tfe-prod"
  workspace_organization_name = "curry-org"
}
