#Reading outputs from remote state file from S3 bucket
data "terraform_remote_state" "vpc_1" {
  backend = "s3"
  config = {
    bucket = "terraform-state-datatf" #updated with bucket name
    key    = "env://${terraform.workspace}/vpc_baston/vpc_baston.tfstate"
    region = var.aws_region
  }
}