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
    "attribute2" = {
      N = "123" # Use the appropriate DynamoDB data type (N for number in this example)
    }
    }
  )
}

