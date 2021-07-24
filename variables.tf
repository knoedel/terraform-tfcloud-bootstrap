variable "org_name" {
  description = "The name of your Terraform Cloud organization. Must be globally unique."
  type        = string
  validation {
    condition     = length(var.org_name) <= 40
    error_message = "The name of the organization cannot have more than 40 characters."
  }
}

variable "org_email" {
  description = "The admin email address for your Terraform Cloud organization."
  type        = string
}

variable "tf_version_prod" {
  description = "The Terraform version for the production workspace."
  default     = "1.0.0"
  type        = string
}

variable "tf_version_sandbox" {
  description = "The Terraform version for the sandbox workspace."
  default     = "1.0.0"
  type        = string
}

variable "enable_two_factor_auth" {
  description = "Require two factor authentication for your Terraform Cloud organization?"
  default     = true
  type        = bool
}

variable "api_token_hetzner_dns" {
  description = "API token for accessing the Hetzner DNS API"
  sensitive   = true
  type        = string
}

variable "api_token_hetzner_cloud_prod" {
  description = "API token for accessing the Hetzner Cloud API in production environment"
  sensitive   = true
  type        = string
}

variable "api_token_hetzner_cloud_sandbox" {
  description = "API token for accessing the Hetzner Cloud API in sandbox environment"
  sensitive   = true
  type        = string
}