terraform {
  backend "s3" {
  }
}

module "lambda" {
  source             = "../module/lambda"
  filename           = "file"
  name               = var.name
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_iam_role.iam_role_arn
  handler_name       = var.handler_name.handler
  runtime            = var.runtime
  security_group_ids = module.lambda_security_group.security_group_arn
  subnet_ids         = data.terraform_remote_state.vpc_2.outputs.private_subnet_id
}

module "lambda_iam_role" {
  source       = "../module/iam_role"
  name         = var.name
  env          = var.env
  aws_region   = var.aws_region
  path_name    = var.path_name
  service_name = var.service_name
  managed_arn  = var.managed_arn
}

module "lambda_security_group" {
  source        = "../module/security_group"
  env           = var.env
  name          = var.env
  vpc_id        = data.terraform_remote_state.vpc_2.outputs.vpc_2_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

}

module "s3_bucket" {
  source           = "../module/s3"
  count            = length(var.bucket_name)
  name             = element(var.bucket_name, count.index)
  enable_lifecycle = var.enable_lifecycle
  acl              = var.acl
  expiration_days  = var.expiration_days
  aws_region       = var.aws_region
  env              = var.env

}

module "email_identities" {
  source          = "../module/ses_identity"
  email_addresses = var.email_addresses

}

module "event_rule" {
  source     = "../module/cloudwatch_event_rule"
  env        = var.env
  aws_region = var.aws_region
  name       = var.name
  event_pattern = jsonencode({
    source : [
      "aws.s3"
    ],
    detail-type : [
      "ObjectCreated:*"
    ],
    resources : [module.s3_bucket.bucket_arn
    ]
  })
  target_arn  = module.lambda.lambda_arn
  target_name = module.lambda.lambda_name
  target_type = var.target_type

}

resource "aws_cloudwatch_event_target" "s3_put_object_event_target" {
  rule      = module.event_rule.event_rule_name
  target_id = module.lambda.lambda_name
  arn       = module.lambda.lambda_arn
  type      = var.target_type
}

