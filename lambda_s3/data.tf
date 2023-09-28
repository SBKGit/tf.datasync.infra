#Reading outputs from remote state file from S3 bucket
data "terraform_remote_state" "vpc2" {
  backend = "s3"
  config = {
    bucket = "datasynctfgmdev" #updated with bucket name
    key    = "${var.env}/vpc2/vpc2.tfstate"
    region = var.aws_region
  }
}

#Reading outputs from remote state file from S3 bucket
data "terraform_remote_state" "sns" {
  backend = "s3"
  config = {
    bucket = "datasynctfgmdev" #updated with bucket name
    key    = "${var.env}/sns/sns.tfstate"
    region = var.aws_region
  }
}

#Reading outputs from remote state file from S3 bucket
data "terraform_remote_state" "sqs" {
  backend = "s3"
  config = {
    bucket = "datasynctfgmdev" #updated with bucket name
    key    = "${var.env}/sqs/sqs.tfstate"
    region = var.aws_region
  }
}

data "terraform_remote_state" "dynamoDB" {
  backend = "s3"
  config = {
    bucket = "datasynctfgmdev" #updated with bucket name
    key    = "${var.env}/dynamoDB/dynamoDB.tfstate"
    region = var.aws_region
  }
}