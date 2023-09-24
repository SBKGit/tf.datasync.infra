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
    name = var.attribute_name
    type = var.attribute_type # String attribute
  }

  hash_key  = var.hash_key
  range_key = var.range_key
  tags = {
    Name        = "${var.name}-dynamoDB"
    Environment = var.env
  }

}

resource "aws_dynamodb_table_item" "dynamoDB" {
  table_name = aws_dynamodb_table.dynamoDB.name
  hash_key   = aws_dynamodb_table.dynamoDB.hash_key
  item       = var.item
}
