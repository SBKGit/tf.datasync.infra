terraform {
  backend "s3" {
  }
}


##---------------------------------##
#-- Lambda configuration start ----##
##---------------------------------##

module "lambda_filename_prefix" {
  source             = "../module/lambda"
  filename           = "filename_prefix_validation.py"
  name               = "filename_prefix_validation"
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_filename_prefix_iam_role.iam_role_arn
  handler_name       = "filename_prefix_validation.lambda_handler"
  runtime            = var.runtime
  security_group_ids = [module.lambda_filename_prefix_sg.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    DYNAMO_TABLE_ERROR_NOTIF = "ErrorNotification"
    DYNAMO_TABLE_PREFIX_LOOKUP = "PrefixLookupTable"
    SNS_TOPIC_ARN = data.terraform_remote_state.sns.outputs.sns_topic_arn
  }
}

module "lambda_filename_prefix_iam_role" {
  source       = "../module/iam_role"
  name         = "filename-prefix-validation-lambda"
  env          = var.env
  aws_region   = var.aws_region
  path_name    = var.path_name
  service_name = var.service_name
  managed_arn  = var.managed_arn
  action_items = var.action_items
}

module "lambda_filename_prefix_sg" {
  source        = "../module/security_group"
  env           = var.env
  name          = "filename-prefix-validation-lambda"
  vpc_id        = data.terraform_remote_state.vpc2.outputs.vpc_2_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

}

module "valid_fufilment" {
  source             = "../module/lambda"
  filename           = "valid_fufilment.py"
  name               = "valid_fufilment"
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_valid_fufilment_iam_role.iam_role_arn
  handler_name       = "valid_fufilment.lambda_handler"
  runtime            = var.runtime
  security_group_ids = [module.valid_fufilment_lambda_sg.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    NOTIF_SQS_NAME = data.terraform_remote_state.sqs.outputs.sqs_notification_name
  }
}

module "lambda_valid_fufilment_iam_role" {
  source       = "../module/iam_role"
  name         = "valid-fufilment-lambda"
  env          = var.env
  aws_region   = var.aws_region
  path_name    = var.path_name
  service_name = var.service_name
  managed_arn  = var.managed_arn
  action_items = var.action_items
}

module "valid_fufilment_lambda_sg" {
  source        = "../module/security_group"
  env           = var.env
  name          = "valid-fufilment-lambda"
  vpc_id        = data.terraform_remote_state.vpc2.outputs.vpc_2_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

}

module "invalid_file" {
  source             = "../module/lambda"
  filename           = "invalid_file.py"
  name               = "invalid_file"
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_invalid_file_iam_role.iam_role_arn
  handler_name       = "invalid_file.lambda_handler"
  runtime            = var.runtime
  security_group_ids = [module.invalid_file_lambda_sg.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    NOTIF_SQS_NAME = data.terraform_remote_state.sqs.outputs.sqs_notification_name
  }
}

module "lambda_invalid_file_iam_role" {
  source       = "../module/iam_role"
  name         = "invalid-file-lambda"
  env          = var.env
  aws_region   = var.aws_region
  path_name    = var.path_name
  service_name = var.service_name
  managed_arn  = var.managed_arn
  action_items = var.action_items
}

module "invalid_file_lambda_sg" {
  source        = "../module/security_group"
  env           = var.env
  name          = "invalid-file-lambda"
  vpc_id        = data.terraform_remote_state.vpc2.outputs.vpc_2_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

}

module "notification" {
  source             = "../module/lambda"
  filename           = "notification.py"
  name               = "notification"
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_notification_iam_role.iam_role_arn
  handler_name       = "notification.lambda_handler"
  runtime            = var.runtime
  security_group_ids = [module.notification_lambda_sg.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    SENDER_EMAIL = data.terraform_remote_state.sqs.outputs.sqs_notification_name
    SWIMLANE = upper(var.env)
  }  
}

module "lambda_notification_iam_role" {
  source       = "../module/iam_role"
  name         = "notification-lambda"
  env          = var.env
  aws_region   = var.aws_region
  path_name    = var.path_name
  service_name = var.service_name
  managed_arn  = var.managed_arn
  action_items = var.action_items
}

module "notification_lambda_sg" {
  source        = "../module/security_group"
  env           = var.env
  name          = "notification-lambda"
  vpc_id        = data.terraform_remote_state.vpc2.outputs.vpc_2_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

}

##---------------------------------##
#-- Lambda configuration start ----##
##---------------------------------##

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


