variable "aws_region" {
  default = "eu-west-2" #please updated in environment.tfvars for change.
}

variable "app_name" {
  default = ""

}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "This is for VPC Datasync VPC CIDR IP range"
}

variable "env" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "private_subnet_cidr" {
  default     = "10.0.1.0/24"
  description = "This block is for private subnet CIDR block"
}

variable "public_subnet_cidr" {
  default     = "10.0.2.0/24"
  description = "This block is for private subnet CIDR block"
}

variable "private_subnet_availability_zone" {
  default     = ["eu-west-2a", "eu-west-2b"] # Replace with your desired AZ
  description = "please provide availability zone "
}

variable "instance_type" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "egress_cidr" {
  default     = ["0.0.0.0/0"]
  description = "please provide valid CIDR block in IPV4"
}

variable "ingress_cidr" {
  default     = ["0.0.0.0/0"]
  description = "please provide valid CIDR block in IPV4"
}

variable "key_name" {
  default = "Ec2_keypair"

}

variable "role_path" {
  default = "/app/"

}
