#backend configuration
terraform {
  backend "s3" {
  }
}

module "app_flow" {
  source       = "../module/appflow"
  name         = "${var.app_name}-${var.env}"
  env          = var.env
  connection_mode = "Public"
  destination_bucket_name = ""
  destination_bucket_prefix = ""
  destination_output_format = ""
  dynamics_instance_url = "https://myorg.southeastasia.dynamics.com/"
  client_id = ""
  client_secret = ""
  organization_name = "myorg"
  profile_Source_connection_type = "Salesforce"
  trigger_type = ""
}