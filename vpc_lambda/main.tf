#backend configuration
terraform {
  backend "s3" {
  }
}

# Create VPC2 (dev)
resource "aws_vpc" "vpc2" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "VPC2_${var.env}"
    Environment = var.env
  }
}

#create internet gateway for bastion access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc2.id
  tags = {
    Name        = "igw_vpc2_${var.env}"
    Environment = var.env
  }
}

# Create a public subnet in VPC2
resource "aws_subnet" "public_subnet_vpc" {
  vpc_id     = aws_vpc.vpc2.id
  cidr_block = var.public_subnet_cidr
  # availability_zone = var.public_subnet_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name        = "Public Subnet VPC2 ${var.env}"
    Environment = var.env
  }
}

# Create an S3 bucket in VPC2 for landing zone
resource "aws_s3_bucket" "landing_zone_bucket_1" {
  bucket = "${var.bucket_name}-${var.env}-bucket-1" # Replace with your bucket name
  acl    = "private"

  tags = {
    Name        = "Landing Zone Bucket 1"
    Environment = var.env
  }
}

# Create an S3 bucket in VPC2 for landing zone
resource "aws_s3_bucket" "landing_zone_bucket_2" {
  bucket = "${var.bucket_name}-${var.env}-bucket-2" # Replace with your bucket name
  acl    = "private"

  tags = {
    Name        = "Landing Zone Bucket 2"
    Environment = var.env
  }
}

# Create an S3 bucket in VPC2 for landing zone
resource "aws_s3_bucket" "landing_zone_bucket_3" {
  bucket = "${var.bucket_name}-${var.env}-bucket-3" # Replace with your bucket name
  acl    = "private"

  tags = {
    Name        = "Landing Zone Bucket 3"
    Environment = var.env
  }
}

# Create a Lambda function in VPC2
resource "aws_lambda_function" "transfer_lambda" {
  filename         = "lambda.zip" # Replace with your Lambda function code
  function_name    = "${var.lambda_name}-${var.env}"
  role             = aws_iam_role.lambda_role.arn
  handler          = "${var.lambda_name}-${var.env}.handler"
  runtime          = var.runtime
  source_code_hash = filebase64sha256("lambda.zip")
  vpc_config {
    subnet_ids         = [aws_subnet.public_subnet_vpc.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
  tags = {
    Name        = "${var.lambda_name} ${var.env}"
    Environment = var.env
  }
}

# Configure IAM role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_name}_${var.env}_iam_role"
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

resource "aws_iam_policy" "lambda_policy" {
  name   = "${var.lambda_name}_${var.env}_policy"
  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": "*",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:CreateNetworkInterface",
                "ec2:AttachNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "autoscaling:CompleteLifecycleAction",
                "ec2:DeleteNetworkInterface"
            ]
        }
        ]
}
EOT
}

resource "aws_iam_policy_attachment" "datasync_agent_policy_attachment" {
  name       = "${var.lambda_name}_${var.env}"
  policy_arn = aws_iam_policy.lambda_policy.arn # Replace with appropriate policy ARN
  roles      = [aws_iam_role.lambda_role.name]
}

# Create security group for Lambda function
resource "aws_security_group" "lambda_sg" {
  name_prefix = "${var.lambda_name}-${var.env}-lambda_sg"
  vpc_id      = aws_vpc.vpc2.id

  # Define inbound and outbound rules here
}

# Create SES configuration for sending emails
/* resource "aws_ses_configuration_set" "email_config_set" {
  name = "${var.lambda_name}_EmailConfigSet"
} */

# Create SES configuration for sending emails
resource "aws_ses_email_identity" "example" {
  count = length(var.email_id)
  email = var.email_id[count.index]
}

# Create EventBridge rule and target
resource "aws_cloudwatch_event_rule" "event_rule" {
  name        = "FileTransferEventRule-${var.env}"
  description = "Rule for triggering Lambda on file transfer"

  event_pattern = jsonencode({
    source      = ["aws.s3"],
    detail_type = ["AWS API Call via CloudTrail"],
    detail = {
      eventSource = ["s3.amazonaws.com"],
      eventName   = ["PutObject"]
    }
  })
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = "${var.lambda_name}-${var.env}-event-rule"
  arn       = aws_lambda_function.transfer_lambda.arn
}

#SQS deadletter queue creation 
resource "aws_sqs_queue" "deadletter_queue" {
  name = "landing-zone-deadletter-queue-${var.env}"

  tags = {
    Name        = "landing-zone-deadletter-queue-${var.env}"
    Environment = var.env
  }
}

#SQS queue creation
resource "aws_sqs_queue" "terraform_queue" {
  name = "landing-zone-queue-${var.env}"

  #optional setting 
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter_queue.arn
    maxReceiveCount     = 5
  })

  tags = {
    Name        = "landing-zone-queue-${var.env}"
    Environment = var.env
  }
}
