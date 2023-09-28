#Reading outputs from remote state file from S3 bucket
data "terraform_remote_state" "lambda_s3" {
  backend = "s3"
  config = {
    bucket = "datasynctfgmdev" #updated with bucket name
    key    = "${var.env}/lambda_s3/lambda_s3.tfstate"
    region = var.aws_region
  }
}