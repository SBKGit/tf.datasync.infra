#Reading outputs from remote state file from S3 bucket
data "terraform_remote_state" "vpc_1" {
  backend = "s3"
  config = {
    bucket = "terraform-state-datatf" #updated with bucket name
    key    = "${var.env}/vpc_bastion/vpc_bastion.tfstate"
    region = var.aws_region
  }
}