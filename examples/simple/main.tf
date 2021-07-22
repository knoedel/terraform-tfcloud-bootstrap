module "bootstrap" {
  source = "../../"

  org_email              = "admin@example.com"
  org_name               = uuid()
  enable_two_factor_auth = false
}
