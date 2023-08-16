# Create VPC2 (dev)
resource "aws_vpc" "vpc2" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "VPC2_${var.env}"
    Environment = var.env
  }
}

# Create a public subnet in VPC2
resource "aws_subnet" "public_subnet_vpc2" {
  vpc_id     = aws_vpc.vpc2.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.public_subnet_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet VPC2"
    Environment = var.env
  }
}

# Create an S3 bucket in VPC2 for landing zone
resource "aws_s3_bucket" "landing_zone_bucket" {
  bucket = "landing-zone-bucket-name-${var.env}"  # Replace with your bucket name
  acl    = "private"
  tags = {
    Name = "Landing Zone Bucket"
    Environment = var.env
  }
}

# Create a Lambda function in VPC2
resource "aws_lambda_function" "transfer_lambda" {
  filename         = "path/to/lambda.zip"  # Replace with your Lambda function code
  function_name    = "${var.lambda_name}_${var.env}"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  source_code_hash = filebase64sha256("path/to/lambda.zip")
  vpc_config {
    subnet_ids = [aws_subnet.public_subnet_vpc2.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  tags = {
    Name = "${var.lambda_name} ${var.env}"
    Environment = var.env
  }
}

# Configure IAM role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_name}_${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Create security group for Lambda function
resource "aws_security_group" "lambda_sg" {
  name_prefix = "${var.lambda_name}-${var.env}-"
  vpc_id      = aws_vpc.vpc2.id

  # Define inbound and outbound rules here
}

# Create SES configuration for sending emails
resource "aws_ses_configuration_set" "email_config_set" {
  name = "${var.lambda_name}_EmailConfigSet"
}

# Create EventBridge rule and target
resource "aws_cloudwatch_event_rule" "event_rule" {
  name        = "FileTransferEventRule-${var.env}"
  description = "Rule for triggering Lambda on file transfer"

  event_pattern = jsonencode({
    source      = ["aws.s3"],
    detail_type = ["AWS API Call via CloudTrail"],
    detail      = {
      eventSource = ["s3.amazonaws.com"],
      eventName   = ["PutObject"]
    }
  })
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = "FileTransferTarget"
  arn       = aws_lambda_function.transfer_lambda.arn
}
