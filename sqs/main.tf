#backend configuration
terraform {
  backend "s3" {
  }
}

module "sqs_vaild_file" {
  source            = "../module/sqs"
  name              = "valid-file"
  env               = var.env
  aws_region        = var.aws_region
  delay_seconds     = var.delay_seconds
  message_size      = var.message_size
  retention_seconds = var.retention_seconds
  receive_wait_time = var.receive_wait_time
}

module "sqs_invaild_file" {
  source            = "../module/sqs"
  name              = "invalid-file"
  env               = var.env
  aws_region        = var.aws_region
  delay_seconds     = var.delay_seconds
  message_size      = var.message_size
  retention_seconds = var.retention_seconds
  receive_wait_time = var.receive_wait_time
}

module "sqs_notification" {
  source            = "../module/sqs"
  name              = "notification"
  env               = var.env
  aws_region        = var.aws_region
  delay_seconds     = var.delay_seconds
  message_size      = var.message_size
  retention_seconds = var.retention_seconds
  receive_wait_time = var.receive_wait_time
}