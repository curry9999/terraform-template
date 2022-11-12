terraform {
  cloud {
    organization = "curry9999"
    hostname     = "app.terraform.io"

    workspaces {
      name = "terraform-template-tfe"
    }
  }
}
