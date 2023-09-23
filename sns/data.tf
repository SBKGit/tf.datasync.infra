#Reading outputs from remote state file from S3 bucket
data "terraform_remote_state" "sqs" {
  backend = "s3"
  config = {
    bucket = "terraform-state-datatf" #updated with bucket name
    key    = "${var.env}/sqs/sqs.tfstate"
    region = var.aws_region
  }
}