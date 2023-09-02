terraform {
  backend "s3" {
    bucket  = "datasynctfgmdev" #updated with bucket name
    key     = "vpc_datasync/vpc_datasync.tfstate"
    encrypt = true
    region  = "eu-west-2"
  }
}
