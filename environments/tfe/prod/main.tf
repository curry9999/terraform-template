module "prod" {
  source                      = "../../../modules/tfe"
  workspace_name              = "terraform-template-tfe-prod"
  workspace_organization_name = "curry-org"
}
