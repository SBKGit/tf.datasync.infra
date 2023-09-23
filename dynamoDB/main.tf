#backend configuration
terraform {
  backend "s3" {
  }
}

module "dynamoDB" {
  source       = "../module/dynamoDB"
  name         = "${var.app_name}-${var.env}"
  billing_mode = var.billing_mode
  encryption   = var.encryption
  env          = var.env
}

resource "aws_dynamodb_table_item" "example" {
  table_name = module.dynamoDB.Name
  hash_key   = aws_dynamodb_table.example.hash_key
  item       = <<ITEM
  {
    "exampleHashKey": {"S": "something"},
    "one": {"N": "11111"},
    "two": {"N": "22222"},
    "three": {"N": "33333"},
    "four": {"N": "44444"}
  }
ITEM
}