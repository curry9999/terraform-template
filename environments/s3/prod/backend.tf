terraform {
  cloud {
    organization = "curry-org"
    hostname     = "app.terraform.io"

    workspaces {
      name = "terraform-workspace-auto-prod"
    }
  }
}
