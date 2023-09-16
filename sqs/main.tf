#backend configuration
terraform {
  backend "s3" {
  }
}

module "sqs" {
  source            = "../module/sqs"
  name              = var.app_name
  env               = var.env
  aws_region        = var.aws_region
  delay_seconds     = var.delay_seconds
  message_size      = var.message_size
  retention_seconds = var.retention_seconds
  receive_wait_time = var.receive_wait_time
}