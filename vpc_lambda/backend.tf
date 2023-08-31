terraform {
  backend "s3" {
    bucket  = "terraform-state-datatf" #updated with bucket name
    key     = "vpc_lambda/vpc_lambda.tfstate"
    encrypt = true
    region  = "eu-west-2"
  }
}