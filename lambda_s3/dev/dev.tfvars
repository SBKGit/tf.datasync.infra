#common variables 
name       = "transfer"
env        = "dev"
aws_region = "eu-west-2"

#S3 bucket variables
bucket_name      = ["landing-bucket-1", "landing-bucket-2", "landing-bucket-3", "error-zone-bucket"]
acl              = "private"
enable_lifecycle = true
expiration_days  = 5
status           = "Enabled"

#lambda iam role variables
path_name    = "/app/"
service_name = ["lambda.amazonaws.com"]
managed_arn  = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]

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
email_addresses = ["emaple@gmail.com", "example2@gmail.com"]

#event variables 

target_type = "lambda"


handler_name = "test.js" #mention file name
runtime      = "nodejs18.x"

action_items = ["ec2:DescribeInstances",
  "ec2:CreateNetworkInterface",
  "ec2:AttachNetworkInterface",
  "ec2:DescribeNetworkInterfaces",
  "autoscaling:CompleteLifecycleAction",
"ec2:DeleteNetworkInterface"]