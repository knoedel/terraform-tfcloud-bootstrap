output "organization_id" {
  description = "The id of your Terraform Cloud organization"
  value       = tfe_organization.main.id
}

output "workspace_id_prod" {
  description = "The id of your Terraform Cloud production workspace"
  value       = tfe_workspace.prod.id
}

output "workspace_id_sandbox" {
  description = "The id of your Terraform Cloud sandbox workspace"
  value       = tfe_workspace.sandbox.id
}
