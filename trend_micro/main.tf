#backend configuration
terraform {
  backend "s3" {
  }
}

#-------------------------------------------#
#----S3 bucket creation for trend micro ----#
#-------------------------------------------#

#Landing zone bucket creation
module "s3_landing_zone" {
  source = "../module/s3"
  name = "landing-zone"
  expiration_days = var.landing_zone_expiration_days
  status = var.landing_zone_status
  acl = var.acl
  aws_region = var.aws_region
}

#To process bucket creation
module "s3_to_process" {
  source = "../module/s3"
  name = "to-process"
  expiration_days = var.to_process_expiration_days
  status = var.to_process_status
  acl = var.acl
  aws_region = var.aws_region
}

#To process bucket creation
module "s3_error_zone" {
  source = "../module/s3"
  name = "error-zone"
  expiration_days = var.error_zone_expiration_days
  status = var.error_zone_status
  acl = var.acl
  aws_region = var.aws_region
}

#----END of S3 bucket creation for trend micro ----#
#--------------------------------------------------#

#-------------------------------------------#
#------Lambda creation for trend micro------#
#-------------------------------------------#

#zip lambda code for uploading to lambda
data "archive_file" "lambda_listener_zip" {
  type        = "zip"
  output_path = "listener_${var.env}.zip"
  source_file = "listener.py"

}

#lambda listener code
module "lambda_listener" {
  source             = "../module/lambda"
  filename           = "listener_${var.env}.zip"
  name               = "listener"
  source_code_hash   = data.archive_file.lambda_listener_zip.output_base64sha256
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_iam_role.iam_role_arn
  handler_name       = "listener.lambda_handler"
  runtime            = "python3.11"
  security_group_ids = [module.lambda_security_group.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    #   DYNAMO_TABLE_ERROR_NOTIF = data.terraform_remote_state.dynamoDB.outputs.dynamoDB_ErrorNotification_name
    #   DYNAMO_TABLE_PREFIX_LOOKUP = data.terraform_remote_state.dynamoDB.outputs.dynamoDB_PrefixLookupTable_name
    #   SNS_TOPIC_ARN = data.terraform_remote_state.sns.outputs.sns_topic_arn
  }

}


#zip lambda code for uploading to lambda
data "archive_file" "lambda_scanner_zip" {
  type        = "zip"
  output_path = "scanner_${var.env}.zip"
  source_file = "scanner.py"

}

#lambda scanner code
module "lambda_scanner" {
  source             = "../module/lambda"
  filename           = "scanner_${var.env}.zip"
  name               = "scanner"
  source_code_hash   = data.archive_file.lambda_scanner_zip.output_base64sha256
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_iam_role.iam_role_arn
  handler_name       = "scanner.lambda_handler"
  runtime            = "python3.11"
  security_group_ids = [module.lambda_security_group.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    #   DYNAMO_TABLE_ERROR_NOTIF = data.terraform_remote_state.dynamoDB.outputs.dynamoDB_ErrorNotification_name
    #   DYNAMO_TABLE_PREFIX_LOOKUP = data.terraform_remote_state.dynamoDB.outputs.dynamoDB_PrefixLookupTable_name
    #   SNS_TOPIC_ARN = data.terraform_remote_state.sns.outputs.sns_topic_arn
  }

}


#zip lambda code for uploading to lambda
data "archive_file" "lambda_update_file_tag_zip" {
  type        = "zip"
  output_path = "update_file_tag_${var.env}.zip"
  source_file = "update_file_tag.py"

}

#lambda update_file_tag code
module "lambda_update_file_tag" {
  source             = "../module/lambda"
  filename           = "update_file_tag_${var.env}.zip"
  name               = "update_file_tag"
  source_code_hash   = data.archive_file.lambda_update_file_tag_zip.output_base64sha256
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_iam_role.iam_role_arn
  handler_name       = "update_file_tag.lambda_handler"
  runtime            = "python3.11"
  security_group_ids = [module.lambda_security_group.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    #   DYNAMO_TABLE_ERROR_NOTIF = data.terraform_remote_state.dynamoDB.outputs.dynamoDB_ErrorNotification_name
    #   DYNAMO_TABLE_PREFIX_LOOKUP = data.terraform_remote_state.dynamoDB.outputs.dynamoDB_PrefixLookupTable_name
    #   SNS_TOPIC_ARN = data.terraform_remote_state.sns.outputs.sns_topic_arn
  }

}

#zip lambda code for uploading to lambda
data "archive_file" "lambda_custom_lambda_zip" {
  type        = "zip"
  output_path = "custom_lambda_${var.env}.zip"
  source_file = "custom_lambda.py"

}

#lambda custom_lambda code
module "lambda_custom" {
  source             = "../module/lambda"
  filename           = "custom_lambda_${var.env}.zip"
  name               = "custom_lambda"
  source_code_hash   = data.archive_file.lambda_custom_lambda_zip.output_base64sha256
  env                = var.env
  aws_region         = var.aws_region
  iam_role           = module.lambda_iam_role.iam_role_arn
  handler_name       = "custom_lambda.lambda_handler"
  runtime            = "python3.11"
  security_group_ids = [module.lambda_security_group.security_group_id]
  subnet_ids         = data.terraform_remote_state.vpc2.outputs.private_subnet_id
  environment_variables = {
    #   DYNAMO_TABLE_ERROR_NOTIF = data.terraform_remote_state.dynamoDB.outputs.dynamoDB_ErrorNotification_name
    #   DYNAMO_TABLE_PREFIX_LOOKUP = data.terraform_remote_state.dynamoDB.outputs.dynamoDB_PrefixLookupTable_name
    #   SNS_TOPIC_ARN = data.terraform_remote_state.sns.outputs.sns_topic_arn
  }
}

#------END of Lambda creation for trend micro------#
#--------------------------------------------------#

#-----------------------------------------------#
#------SQS and SNS creation for Trend Micro-----#
#-----------------------------------------------#

#SQS creation for trend micro
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

module "sns_topic_data" {
  source = "../module/sns"
  name   = "trend_micro"
  env    = var.env
}   

module "sns_topic_subscription_valid_file" {
  source               = "../module/sns_subscriptions"
  name                 = "trend_micro"
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

