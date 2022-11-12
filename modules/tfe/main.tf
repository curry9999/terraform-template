resource "tfe_workspace" "test" {
  name           = var.workspace_name
  organization   = var.workspace_organization_name
  execution_mode = "local"
}
