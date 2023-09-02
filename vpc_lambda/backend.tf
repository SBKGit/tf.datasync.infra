terraform {
  backend "s3" {
    bucket  = "datasynctfgmdev" #updated with bucket name
    key     = "vpc_lambda/vpc_lambda.tfstate"
    encrypt = true
    region  = "eu-west-2"
  }
}
