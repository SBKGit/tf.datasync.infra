terraform {
  backend "s3" {
    bucket  = "terraform-state-datatf" #updated with bucket name
    key     = "vpc_bastion/vpc_bastion.tfstate"
    encrypt = true
    region  = "eu-west-2"
  }
}
