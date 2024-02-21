#common variables 
env        = "dev"
aws_region = "eu-west-2"

#S3 bucket variables
acl              = "private"
enable_lifecycle = true

#landing zone s3 variable
landing_zone_expiration_days  = 5
landing_zone_status           = "Enabled"

#To process s3 variable
to_process_expiration_days  = 5
to_process_status           = "Enabled"

#Error zone s3 variable
error_zone_expiration_days  = 5
error_zone_status           = "Enabled"

#lambda iam role variables
path_name    = "/app/"
service_name = ["lambda.amazonaws.com", "s3.amazonaws.com"]
managed_arn  = ["arn:aws:iam::aws:policy/AWSLambdaExecute", "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess", "arn:aws:iam::aws:policy/AmazonSQSFullAccess", "arn:aws:iam::aws:policy/AmazonSNSFullAccess", "arn:aws:iam::aws:policy/AmazonSESFullAccess"]

#lambda security group variables


ingress_rules = {
  rule1 = {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = []
  }
}

egress_rules = {
  rule1 = {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = []
  }
}

#email id's for notification
email_addresses = ["example@gmail.com", "example2@gmail.com"]

#event variables 

target_type = "lambda"


handler_name = "test.js" #mention file name

action_items = ["ec2:DescribeInstances",
  "ec2:CreateNetworkInterface",
  "ec2:AttachNetworkInterface",
  "ec2:DescribeNetworkInterfaces",
  "autoscaling:CompleteLifecycleAction",
  "ec2:DeleteNetworkInterface",
"logs:*"]