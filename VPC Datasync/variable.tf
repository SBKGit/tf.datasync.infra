variable "aws_region" {
  default = "eu-west-2" #please updated in environment.tfvars for change.
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "This is for VPC Datasync VPC CIDR IP range"
}

variable "env" {
  default = "dev.tfvars"
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "private_subnet_cidr" {
  default = "10.0.1.0/24"
  description = "This block is for private subnet CIDR block"
}

variable "private_subnet_availability_zone" {
  default = ["eu-west-2","eu-west-1"] # Replace with your desired AZ
  type = "list"
  description = "please provide availability zone "
}

variable "instance_type" {
  default = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "ami_version" {
  description = "Version of the AMI to deploy by default it will be pick-up"
  type        = string
  default     = data.aws_ami.datasync_ami.id
}

data "aws_ami" "datasync_ami" {
  most_recent = true
  name_regex  = "Amazon Linux 2"

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}