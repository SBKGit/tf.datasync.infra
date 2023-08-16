terraform {
  backend "s3" {
    bucket = "mybucket" #updated with bucket name
    key    = "dev/vpc_datasync/vpc_datasync.tfstate"
    encrypt= true
    region = var.aws_region
  }
}
