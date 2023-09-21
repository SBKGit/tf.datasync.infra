#common variables 
name       = "transfer"
env        = "dev"
aws_region = "eu-west-2"

#S3 bucket variables
bucket_name      = ["landing-bucket1", "landing-bucket2", "landing-bucket3"]
acl              = "private"
enable_lifecycle = true
expiration_days  = 5

#lambda iam role variables
path_name   = "/app/"
managed_arn = ["lambda.amazonaws.com"]

#lambda security group variables

handler_name = "filename" #mention file name
runtime      = ""
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
