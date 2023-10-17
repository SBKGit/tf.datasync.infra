terraform {
  backend "s3" {
  }
}


##---------------------------------##
#-- Lambda configuration start ----##
##---------------------------------##


data "archive_file" "lambda_filename_prefix_zip" {
  type        = "zip"
  output_path = "filename_prefix_${var.env}.zip"
  source_file = "filename_prefix_validation.py"

}

module "lambda_filename_prefix" {
  source             = "../module/lambda"
  filename           = "filename_prefix_${var.env}.zip"
  name               = "filename_prefix_validation"
  source_code_hash   = data.archive_file.lambda_filename_prefix_zip.output_base64sha256
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_iam_role.iam_role_arn
  handler_name       = "filename_prefix_validation.lambda_handler"
  runtime            = var.runtime
  security_group_ids = [module.lambda_security_group.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    #   DYNAMO_TABLE_ERROR_NOTIF = data.terraform_remote_state.dynamoDB.outputs.dynamoDB_ErrorNotification_name
    #   DYNAMO_TABLE_PREFIX_LOOKUP = data.terraform_remote_state.dynamoDB.outputs.dynamoDB_PrefixLookupTable_name
    #   SNS_TOPIC_ARN = data.terraform_remote_state.sns.outputs.sns_topic_arn
  }

}


module "lambda_iam_role" {
  source       = "../module/iam_role"
  name         = "transfer-lambda"
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
  name          = "filename-prefix-validation-lambda"
  vpc_id        = data.terraform_remote_state.vpc2.outputs.vpc_2_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

}

data "archive_file" "lambda_valid_fufilment_zip" {
  type        = "zip"
  output_path = "valid_fufilment_${var.env}.zip"
  source_file = "valid_fufilment.py"

}

module "valid_fufilment" {
  source             = "../module/lambda"
  filename           = "valid_fufilment_${var.env}.zip"
  name               = "valid_fufilment"
  source_code_hash   = data.archive_file.lambda_valid_fufilment_zip.output_base64sha256
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_iam_role.iam_role_arn
  handler_name       = "valid_fufilment.lambda_handler"
  runtime            = var.runtime
  security_group_ids = [module.valid_fufilment_lambda_sg.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    # NOTIF_SQS_NAME = data.terraform_remote_state.sqs.outputs.sqs_notification_name
  }
}

module "valid_fufilment_lambda_sg" {
  source        = "../module/security_group"
  env           = var.env
  name          = "valid-fufilment-lambda"
  vpc_id        = data.terraform_remote_state.vpc2.outputs.vpc_2_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

}

data "archive_file" "lambda_invalidfile_zip" {
  type        = "zip"
  output_path = "invalid_file_${var.env}.zip"
  source_file = "invalid_file.py"

}

module "invalid_file" {
  source             = "../module/lambda"
  filename           = "invalid_file_${var.env}.zip"
  name               = "invalid_file"
  source_code_hash   = data.archive_file.lambda_invalidfile_zip.output_base64sha256
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_iam_role.iam_role_arn
  handler_name       = "invalid_file.lambda_handler"
  runtime            = var.runtime
  security_group_ids = [module.invalid_file_lambda_sg.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    # NOTIF_SQS_NAME = data.terraform_remote_state.sqs.outputs.sqs_notification_name
  }
}

module "invalid_file_lambda_sg" {
  source        = "../module/security_group"
  env           = var.env
  name          = "invalid-file-lambda"
  vpc_id        = data.terraform_remote_state.vpc2.outputs.vpc_2_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

}
data "archive_file" "lambda_notification_zip" {
  type        = "zip"
  output_path = "notification_${var.env}.zip"
  source_file = "notification.py"

}

module "notification" {
  source             = "../module/lambda"
  filename           = "notification_${var.env}.zip"
  name               = "notification"
  source_code_hash   = data.archive_file.lambda_notification_zip.output_base64sha256
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_iam_role.iam_role_arn
  handler_name       = "notification.lambda_handler"
  runtime            = var.runtime
  security_group_ids = [module.notification_lambda_sg.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    # SENDER_EMAIL = data.terraform_remote_state.sqs.outputs.sqs_notification_name
    # SWIMLANE = upper(var.env)
  }
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
    resources : [module.s3_bucket_1.s3_arn]
  })
  target_arn = module.lambda_filename_prefix.lambda_arn
  target_id  = module.lambda_filename_prefix.lambda_name

}

resource "aws_lambda_permission" "allow_stop_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_filename_prefix.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = module.event_rule.event_rule_arn

}

