// Organizations

resource "tfe_organization" "infra" {
  email                    = var.org_email
  name                     = "${var.org_name}-infra"
  collaborator_auth_policy = var.enable_two_factor_auth ? "two_factor_mandatory" : "password"
}

resource "tfe_organization" "org-root" {
  email                    = var.org_email
  name                     = "${var.org_name}-org-root"
  collaborator_auth_policy = var.enable_two_factor_auth ? "two_factor_mandatory" : "password"
}

resource "tfe_organization" "prod" {
  email                    = var.org_email
  name                     = "${var.org_name}-prod"
  collaborator_auth_policy = var.enable_two_factor_auth ? "two_factor_mandatory" : "password"
}

resource "tfe_organization" "sandbox" {
  email                    = var.org_email
  name                     = "${var.org_name}-sandbox"
  collaborator_auth_policy = var.enable_two_factor_auth ? "two_factor_mandatory" : "password"
}

// Workspaces

resource "tfe_workspace" "infra_admin-global" {
  name                = "admin-global"
  description         = "${var.org_name} infra admin-global infrastructure"
  organization        = tfe_organization.infra.id
  terraform_version   = var.tf_version_prod
  speculative_enabled = false
}

resource "tfe_workspace" "org-root_admin-global" {
  name                = "admin-global"
  description         = "${var.org_name} org-root admin-global infrastructure"
  organization        = tfe_organization.org-root.id
  terraform_version   = var.tf_version_prod
  speculative_enabled = false
}

resource "tfe_workspace" "prod_admin-global" {
  name                = "admin-global"
  description         = "${var.org_name} prod admin-global infrastructure"
  organization        = tfe_organization.prod.id
  terraform_version   = var.tf_version_prod
  speculative_enabled = false
}

resource "tfe_workspace" "sandbox_admin-global" {
  name                = "admin-global"
  description         = "${var.org_name} sandbox admin-global infrastructure"
  organization        = tfe_organization.sandbox.id
  terraform_version   = var.tf_version_sandbox
  speculative_enabled = false
}

// Variables

locals {
  sandbox_workspaces = {
    sandbox_admin-global = tfe_workspace.sandbox_admin-global.id
  }
  production_workspaces = {
    infra_admin-global    = tfe_workspace.infra_admin-global.id
    org-root_admin-global = tfe_workspace.org-root_admin-global.id
    prod_admin-global     = tfe_workspace.prod_admin-global.id
  }
}

resource "tfe_variable" "prod_hetzner_dns_api_token" {
  for_each = local.production_workspaces

  category     = "env"
  key          = "HETZNER_DNS_API_TOKEN"
  workspace_id = each.value
  sensitive    = true
  description  = "API token for Hetzner DNS"
  value        = var.api_token_hetzner_dns
}

resource "tfe_variable" "prod_hetzner_cloud_api_token" {
  for_each = local.production_workspaces

  category     = "env"
  key          = "HCLOUD_TOKEN"
  workspace_id = each.value
  sensitive    = true
  description  = "API token for Hetzner Cloud API"
  value        = var.api_token_hetzner_cloud_prod
}

resource "tfe_variable" "sandbox_hetzner_dns_api_token" {
  for_each = local.sandbox_workspaces

  category     = "env"
  key          = "HETZNER_DNS_API_TOKEN"
  workspace_id = each.value
  sensitive    = true
  description  = "API token for Hetzner DNS API"
  value        = var.api_token_hetzner_dns
}

resource "tfe_variable" "sandbox_hetzner_cloud_api_token" {
  for_each = local.sandbox_workspaces

  category     = "env"
  key          = "HCLOUD_TOKEN"
  workspace_id = each.value
  sensitive    = true
  description  = "API token for Hetzner Cloud API"
  value        = var.api_token_hetzner_cloud_sandbox
}
