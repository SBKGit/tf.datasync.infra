
module "dynamoDB" {
  source       = "../module/dynamoDB"
  name         = "${var.app_name}-${var.env}"
  billing_mode = var.billing_mode
  encryption   = var.encryption
  env          = var.env
}