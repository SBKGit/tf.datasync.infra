terraform {
  backend "s3" {
    bucket  = "datasynctfgmdev" #updated with bucket name
    key     = "vpc_bastion/vpc_bastion.tfstate"
    encrypt = true
    region  = "eu-west-2"
  }
}
