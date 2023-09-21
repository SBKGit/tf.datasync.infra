#create lambda function
resource "aws_lambda_function" "lambda" {
  filename      = var.filename
  function_name = "${var.name}_${var.env}_lambda"
  role          = var.iam_role
  handler       = var.handler_name
  runtime       = var.runtime
  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }

  tags = {
    Name        = "${var.name} ${var.env} ${var.runtime}"
    Environment = var.env
  }
}