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

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
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
