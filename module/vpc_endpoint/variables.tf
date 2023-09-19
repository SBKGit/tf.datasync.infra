variable "name" {
  default = ""
}

variable "env" {
  default = ""

}

variable "vpc_id" {
  default = ""

}

variable "aws_region" {
  default = ""
}

variable "subnet_id" {
  default = ""

}

variable "security_group" {
  default = []
  
}

variable "vpc_endpoint_type" {
  default = "Interface"

}