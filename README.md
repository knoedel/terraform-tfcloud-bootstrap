# Bootstrapping Terraform Cloud

This module provisions [Terraform Cloud](https://app.terraform.io/) workspaces that you can use as remote state buckets.

You should keep a local state file in the repo that only manages the basic resources for bootstrapping:

* Terraform Cloud organization
* Terraform Cloud production workspace
* Terraform Cloud sandbox workspace for testing

## Usage for bootstrapping

```hcl
module "bootstrap" {
  source = "github.com/knoedel/terraform-tfcloud-bootstrap?ref=master"

  <variables>
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.25 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.25.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_organization.main](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/organization) | resource |
| [tfe_variable.prod_hetzner_cloud_api_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.prod_hetzner_dns_api_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sandbox_hetzner_cloud_api_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sandbox_hetzner_dns_api_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.prod](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_workspace.sandbox](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_token_hetzner_cloud_prod"></a> [api\_token\_hetzner\_cloud\_prod](#input\_api\_token\_hetzner\_cloud\_prod) | API token for accessing the Hetzner Cloud API in production environment | `string` | n/a | yes |
| <a name="input_api_token_hetzner_cloud_sandbox"></a> [api\_token\_hetzner\_cloud\_sandbox](#input\_api\_token\_hetzner\_cloud\_sandbox) | API token for accessing the Hetzner Cloud API in sandbox environment | `string` | n/a | yes |
| <a name="input_api_token_hetzner_dns"></a> [api\_token\_hetzner\_dns](#input\_api\_token\_hetzner\_dns) | API token for accessing the Hetzner DNS API | `string` | n/a | yes |
| <a name="input_enable_two_factor_auth"></a> [enable\_two\_factor\_auth](#input\_enable\_two\_factor\_auth) | Require two factor authentication for your Terraform Cloud organization? | `bool` | `true` | no |
| <a name="input_org_email"></a> [org\_email](#input\_org\_email) | The admin email address for your Terraform Cloud organization. | `string` | n/a | yes |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | The name of your Terraform Cloud organization. Must be globally unique. | `string` | n/a | yes |
| <a name="input_tf_version_prod"></a> [tf\_version\_prod](#input\_tf\_version\_prod) | The Terraform version for the production workspace. | `string` | `"1.0.0"` | no |
| <a name="input_tf_version_sandbox"></a> [tf\_version\_sandbox](#input\_tf\_version\_sandbox) | The Terraform version for the sandbox workspace. | `string` | `"1.0.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_organization_id"></a> [organization\_id](#output\_organization\_id) | The id of your Terraform Cloud organization |
| <a name="output_workspace_id_prod"></a> [workspace\_id\_prod](#output\_workspace\_id\_prod) | The id of your Terraform Cloud production workspace |
| <a name="output_workspace_id_sandbox"></a> [workspace\_id\_sandbox](#output\_workspace\_id\_sandbox) | The id of your Terraform Cloud sandbox workspace |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Bootstrapping

Create a new directory in your Terraform config repository, e.g. `terraform/org-root/bootstrap`.

Add a `bootstrap/main.tf` file as described in [the example above](#usage-for-bootstrapping).
Make sure that the required `hashicorp/tfe` provider is available and configured:

```hcl
terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "~> 0.25"
    }
  }
}

provider "tfe" {
  token = var.token
}
```

Execute terraform to start the bootstrapping process:

```shell
terraform init && terraform plan

# Make sure the changes are as intended
terraform apply
```

A local state file has been generated. Make sure to commit this file to your repository.

## Developer Setup

Install dependencies

```shell
go mod download
make ensure_pre_commit
```

### Testing

[Terratest](https://github.com/gruntwork-io/terratest) is being used for
automated testing with this module. Tests in the `test` folder can be run
locally by running the following command:

```text
make test
```
