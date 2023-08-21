terraform {
  backend "s3" {
    bucket = "terraform-state-datatf" #updated with bucket name
    key    = "dev/vpc_datasync/vpc_datasync.tfstate"
    encrypt= true
    region = "eu-west-2"
  }
}
