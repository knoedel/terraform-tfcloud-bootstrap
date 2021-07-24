module "bootstrap" {
  source = "../../"

  org_email              = "admin@example.com"
  org_name               = uuid()
  enable_two_factor_auth = false

  api_token_hetzner_dns           = "API TOKEN"
  api_token_hetzner_cloud_prod    = "API TOKEN"
  api_token_hetzner_cloud_sandbox = "API TOKEN"
}
