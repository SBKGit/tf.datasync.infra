#backend configuration
terraform {
  backend "s3" {
  }
}

module "sns_vpc2" {
  source = "../module/sns"
  name   = var.app_name
  env    = var.env
}