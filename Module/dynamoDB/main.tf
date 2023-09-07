#create dynamoDB 
resource "aws_dynamodb_table" "dynamoDB" {
  name           = "${var.name}-dynamoDB"
  billing_mode   = var.billing_mode # You can also use "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
server_side_encryption = var.encryption
  attribute {
    name = "pk"
    type = "S" # String attribute
  }

  attribute {
    name = "sk"
    type = "N" # Numeric attribute
  }

  key_schema {
    attribute_name = "pk"
    key_type       = "HASH"
  }

  key_schema {
    attribute_name = "sk"
    key_type       = "RANGE"
  }
    tags = {
    Name        = "${var.name}-dynamoDB"
    Environment = var.env
  }

}
