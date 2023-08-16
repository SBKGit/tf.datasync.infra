terraform {
  backend "s3" {
    bucket = "mybucket" #updated with bucket name
    key    = "dev/vpc_lambda/vpc_lambda.tfstate"
    encrypt= true
    region = var.aws_region
  }
}
