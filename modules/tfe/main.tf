resource "tfe_workspace" "main" {
  name           = var.workspace_name
  organization   = var.workspace_organization_name
  execution_mode = "local"
}
