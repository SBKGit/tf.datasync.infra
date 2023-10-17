#backend configuration
terraform {
  backend "s3" {
  }
}

module "dynamoDB" {
  source         = "../module/dynamoDB"
  name           = "${var.app_name}-${var.env}"
  billing_mode   = var.billing_mode
  encryption     = var.encryption
  env            = var.env
  hash_key       = "prefix"
  attribute_name = "prefix"
  attribute_type = "S"
  item = jsonencode({

    "prefix" = {
      S = "TXC" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "BizSuccessNotif" = {
      S = "Y" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "BusinessEmailAddress" = {
      S = "shireesh.kantharaj@tfgm.com" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "FufilmentFlag" = {
      S = "Y" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "NotificationEmailFlag" = {
      S = "Y" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "SupportEmailAddress" = {
      S = "shireesh.kantharaj@tfgm.com" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "Source" = {
      S = "Trapeze" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "TargetBucket" = {
      S = "opc-ticketer-data-dev" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "TechSupportSuccessNotif" = {
      S = "Y" # Use the appropriate DynamoDB data type (S for string in this example)
    }
    }
  )
}

module "ErrorNotification" {
  source         = "../module/dynamoDB"
  name           = "ErrorNotification-${var.env}"
  billing_mode   = var.billing_mode
  encryption     = var.encryption
  env            = var.env
  hash_key       = "SourceBucket"
  attribute_name = "SourceBucket"
  attribute_type = "S"
  item = jsonencode({

    "SourceBucket" = {
      S = data.terraform_remote_state.lambda_s3.outputs.s3_bucket_name_1 # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "BizSuccessNotif" = {
      S = "Y" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "BusinessEmailAddress" = {
      S = "shireesh.kantharaj@tfgm.com" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "SupportEmailAddress" = {
      S = "shireesh.kantharaj@tfgm.com" # Use the appropriate DynamoDB data type (S for string in this example)
    },
    "TargetBucket" = {
      S = data.terraform_remote_state.lambda_s3.outputs.s3_bucket_name_4 # Use the appropriate DynamoDB data type (S for string in this example)
    }
    }
  )
}
