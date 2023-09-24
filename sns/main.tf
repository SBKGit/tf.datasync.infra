#backend configuration
terraform {
  backend "s3" {
  }
}

module "sns_topic_data" {
  source = "../module/sns"
  name   = var.app_name
  env    = var.env
}

module "sns_topic_subscription_valid_file" {
  source               = "../module/sns_subscriptions"
  name                 = var.app_name
  env                  = var.env
  aws_region           = var.aws_region
  topic_arn            = module.sns_topic_data.sns_topic_arn
  protocol             = "sqs"
  endpoint             = data.terraform_remote_state.sqs.outputs.sqs_valid_file_arn
  enable_filter_policy = true
  filter_policy = jsonencode({
    "Valid" : ["true"]
  })
}

module "sns_topic_subscription_invalid_file" {
  source               = "../module/sns_subscriptions"
  name                 = var.app_name
  env                  = var.env
  aws_region           = var.aws_region
  topic_arn            = module.sns_topic_data.sns_topic_arn
  protocol             = "sqs"
  endpoint             = data.terraform_remote_state.sqs.outputs.sqs_invalid_file_arn
  enable_filter_policy = true
  filter_policy = jsonencode({
    "Valid" : ["false"]
  })
}