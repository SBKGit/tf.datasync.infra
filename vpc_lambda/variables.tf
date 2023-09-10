variable "aws_region" {
  default = "eu-west-2" #please updated in environment.tfvars for change.
}

variable "lambda_name" {
  default     = "transfer-lambda"
  description = "please provide valid lambda name"
}

variable "bucket_name" {
  default     = "Landing-zone"
  description = "please provide valid lambda name"
}


variable "vpc_cidr" {
  default     = "10.1.0.0/16"
  description = "This is for VPC Data sync VPC CIDR IP range"
}

variable "env" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "public_subnet_cidr" {
  default     = "10.1.1.0/24"
  description = "This block is for private subnet CIDR block"
}

variable "public_subnet_availability_zone" {
  default     = ["eu-west-2a", "eu-west-2b"] # Replace with your desired AZ
  type        = list(string)
  description = "please provide availability zone "
}

variable "email_id" {
  default = ["example@gmail.com","example2@gmail.com"]
}

variable "runtime" {
  default = "nodejs14.x"
  
}