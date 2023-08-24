terraform {
  backend "s3" {
    bucket  = "terraform-state-datatf" #updated with bucket name
    key     = "vpc_baston/vpc_baston.tfstate"
    encrypt = true
    region  = "eu-west-2"
  }
}
