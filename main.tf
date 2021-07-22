resource "tfe_organization" "main" {
  email                    = var.org_email
  name                     = var.org_name
  collaborator_auth_policy = var.enable_two_factor_auth ? "two_factor_mandatory" : "password"
}

resource "tfe_workspace" "prod" {
  name                = "infrastructure-prod"
  description         = "${var.org_name} production infrastructure"
  organization        = tfe_organization.main.id
  terraform_version   = var.tf_version_prod
  speculative_enabled = false
}

resource "tfe_workspace" "sandbox" {
  name                = "infrastructure-sandbox"
  description         = "${var.org_name} playground infrastructure"
  organization        = tfe_organization.main.id
  terraform_version   = var.tf_version_sandbox
  speculative_enabled = false
}
