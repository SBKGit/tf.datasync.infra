variable "name" {
  default = ""
}

variable "env" {
  default = ""

}

variable "vpc_id" {
  default = ""

}

variable "route" {
  description = "Route configuration for the route table"
  type = list(object({
    cidr_block = string
    gateway_id = string
  }))
}

variable "aws_region" {
  default = ""
}