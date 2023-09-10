#create dynamoDB 
resource "aws_dynamodb_table" "dynamoDB" {
  name           = "${var.name}-dynamoDB"
  billing_mode   = var.billing_mode # You can also use "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  server_side_encryption {
    enabled = var.encryption
  }
  attribute {
    name = "pk"
    type = "S" # String attribute
  }

  attribute {
    name = "sk"
    type = "N" # Numeric attribute
  }

  hash_key  = "pk"
  range_key = "sk"

  tags = {
    Name        = "${var.name}-dynamoDB"
    Environment = var.env
  }

}
