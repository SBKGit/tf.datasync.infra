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
  service_name = ["lambda.amazonaws.com"]
  managed_arn  = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
  action_items = [
    "ec2:DescribeAccountAttributes",
    "ec2:DescribeAvailabilityZones",
    "ec2:DescribeImages",
    "ec2:DescribeInstanceAttribute",
    "ec2:DescribeInstances",
    "ec2:DescribeKeyPairs",
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
  runtime      = var.runtime
  filename     = data.archive_file.start_source.output_path
  handler_name = "start_instance.handler"
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
  runtime      = var.runtime
  filename     = data.archive_file.stop_source.output_path
  handler_name = "stop_instance.handler"
}