#backend configuration
terraform {
  backend "s3" {
  }
}

#create iam role for lambda
module "lambda_iam_role" {
  source       = "../module/iam_role"
  name         = var.app_name
  env          = var.env
  path_name    = "/app/"
  service_name = ["lambda.amazonaws.com"]
  managed_arn  = ["arn:aws:iam::aws:policy/AutoScalingFullAccess","arn:aws:iam::aws:policy/AmazonEC2FullAccess","arn:aws:iam::aws:policy/AWSLambdaExecute"]
  action_items = [
    "ec2:DescribeAccountAttributes",
    "ec2:DescribeAvailabilityZones",
    "ec2:DescribeImages",
    "ec2:DescribeInstanceAttribute",
    "ec2:DescribeInstances",
    "ec2:DescribeLaunchTemplateVersions",
    "ec2:DescribePlacementGroups",
    "ec2:DescribeSecurityGroups",
    "ec2:DescribeSpotInstanceRequests",
    "ec2:DescribeSubnets",
  "ec2:DescribeVpcClassicLink"]

}

#zip the file to lambda
data "archive_file" "start_source" {
  type        = "zip"
  source_dir  = "start_instance"
  output_path = "start_lambda_function.zip"
}


#create start lambda for schedular
module "start_lambda" {
  source       = "../module/lambda"
  name         = "${var.app_name}_start_lambda"
  env          = var.env
  iam_role     = module.lambda_iam_role.iam_role_arn
  runtime      = "python3.11"
  filename     = data.archive_file.start_source.output_path
  handler_name = "start_instance.lambda_handler"
  environment_variables = {
    asg_name = "test_1-asg,test_2-asg"
  }
}

#zip the file to lambda
data "archive_file" "stop_source" {
  type        = "zip"
  source_dir  = "stop_instance"
  output_path = "stop_lambda_function.zip"
}
#create stop lambda for schedular 
module "stop_lambda" {
  source       = "../module/lambda"
  name         = "${var.app_name}_stop_lambda"
  env          = var.env
  iam_role     = module.lambda_iam_role.iam_role_arn
  runtime      = "python3.11"
  filename     = data.archive_file.stop_source.output_path
  handler_name = "stop_instance.lambda_handler"
  environment_variables = {
    asg_name = "test_1-asg,test_2-asg"
  }
}

module "event_schedule_start" {
  source = "../module/cloudwatch_cron_lambda"
  name = "${var.app_name}_start"
  env = var.env
  aws_region = var.aws_region
  lambda_arn = module.start_lambda.lambda_arn
  cron_expression = "cron(0 7 ? * MON-FRI *)"
  state = "enabled"
  
}

module "event_schedule_stop" {
  source = "../module/cloudwatch_cron_lambda"
  name = "${var.app_name}_stop"
  env = var.env
  aws_region = var.aws_region
  lambda_arn = module.stop_lambda.lambda_arn
  cron_expression = "cron(0 19 ? * MON-FRI *)"
  state = "enabled"
  
}