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

resource "tfe_variable" "prod_hetzner_dns_api_token" {
  category     = "env"
  key          = "HETZNER_DNS_API_TOKEN"
  workspace_id = tfe_workspace.prod.id
  sensitive    = true
  description  = "API token for Hetzner DNS"
  value        = var.api_token_hetzner_dns
}

resource "tfe_variable" "prod_hetzner_cloud_api_token" {
  category     = "env"
  key          = "HCLOUD_TOKEN"
  workspace_id = tfe_workspace.prod.id
  sensitive    = true
  description  = "API token for Hetzner Cloud API"
  value        = var.api_token_hetzner_cloud_prod
}

resource "tfe_workspace" "sandbox" {
  name                = "infrastructure-sandbox"
  description         = "${var.org_name} playground infrastructure"
  organization        = tfe_organization.main.id
  terraform_version   = var.tf_version_sandbox
  speculative_enabled = false
}

resource "tfe_variable" "sandbox_hetzner_dns_api_token" {
  category     = "env"
  key          = "HETZNER_DNS_API_TOKEN"
  workspace_id = tfe_workspace.sandbox.id
  sensitive    = true
  description  = "API token for Hetzner DNS API"
  value        = var.api_token_hetzner_dns
}

resource "tfe_variable" "sandbox_hetzner_cloud_api_token" {
  category     = "env"
  key          = "HCLOUD_TOKEN"
  workspace_id = tfe_workspace.sandbox.id
  sensitive    = true
  description  = "API token for Hetzner Cloud API"
  value        = var.api_token_hetzner_cloud_sandbox
}
