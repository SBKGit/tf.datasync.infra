variable "vpc_cidr" {
  default = ""

}

variable "private_cidr_block" {
  default = ""

}

variable "public_cidr_block" {
  default = ""

}

variable "aws_region" {
  default = ""

}

variable "env" {
  default = ""

}

variable "vpc_name" {
  default     = ""
  type        = string
  description = "(optional) describe your variable"
}

