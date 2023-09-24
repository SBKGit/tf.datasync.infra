terraform {
  backend "s3" {
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${var.name}_${var.env}.zip"
  source_file = "${var.env}/${var.handler_name}"

}

module "lambda_filename_prefix" {
  source             = "../module/lambda"
  filename           = "${var.name}_${var.env}.zip"
  name               = "filename_prefix_validation"
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_iam_role.iam_role_arn
  handler_name       = "${var.handler_name}.handler"
  runtime            = var.runtime
  security_group_ids = [module.lambda_security_group.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
}

module "lambda_iam_role" {
  source       = "../module/iam_role"
  name         = "${var.name}-lambda"
  env          = var.env
  aws_region   = var.aws_region
  path_name    = var.path_name
  service_name = var.service_name
  managed_arn  = var.managed_arn
  action_items = var.action_items
}

module "lambda_security_group" {
  source        = "../module/security_group"
  env           = var.env
  name          = var.name
  vpc_id        = data.terraform_remote_state.vpc2.outputs.vpc_2_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

}

module "s3_bucket_1" {
  source           = "../module/s3"
  name             = var.bucket_name[0]
  enable_lifecycle = var.enable_lifecycle
  acl              = var.acl
  expiration_days  = var.expiration_days
  aws_region       = var.aws_region
  env              = var.env
  status           = var.status

}

module "s3_notification_bucket_1" {
  source      = "../module/s3_notification_lambda"
  eventbridge = true
  bucket_id   = module.s3_bucket_1.s3_id
  aws_region  = var.aws_region

}

module "s3_bucket_2" {
  source           = "../module/s3"
  name             = var.bucket_name[1]
  enable_lifecycle = var.enable_lifecycle
  acl              = var.acl
  expiration_days  = var.expiration_days
  aws_region       = var.aws_region
  env              = var.env
  status           = var.status
}

module "s3_notification_bucket_2" {
  source      = "../module/s3_notification_lambda"
  eventbridge = true
  bucket_id   = module.s3_bucket_2.s3_id
  aws_region  = var.aws_region

}

module "s3_bucket_3" {
  source           = "../module/s3"
  name             = var.bucket_name[2]
  enable_lifecycle = var.enable_lifecycle
  acl              = var.acl
  expiration_days  = var.expiration_days
  aws_region       = var.aws_region
  env              = var.env
  status           = var.status
}

module "s3_notification_bucket_3" {
  source      = "../module/s3_notification_lambda"
  eventbridge = true
  bucket_id   = module.s3_bucket_3.s3_id
  aws_region  = var.aws_region

}

module "s3_bucket_4" {
  source           = "../module/s3"
  name             = var.bucket_name[3]
  enable_lifecycle = var.enable_lifecycle
  acl              = var.acl
  expiration_days  = var.expiration_days
  aws_region       = var.aws_region
  env              = var.env
  status           = var.status
}

module "email_identities" {
  source          = "../module/ses_identity"
  email_addresses = var.email_addresses
  aws_region      = var.aws_region

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
    resources : [module.s3_bucket_1.s3_arn, module.s3_bucket_3.s3_arn, module.s3_bucket_3.s3_arn
    ]
  })
  target_arn = module.lambda_filename_prefix.lambda_arn
  target_id  = module.lambda_filename_prefix.lambda_name


}


