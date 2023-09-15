variable "ingress_rules" {
  type = map(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = string
    },
    {
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      security_groups = string
    }

  ))
  description = "Map of ingress rules"
}

variable "egress_rules" {
  type = map(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = string
    },
    {
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      security_groups = string
    }

  ))
  description = "Map of ingress rules"
}

variable "vpc_id" {
  default = ""
}

variable "name" {
  default = ""
}

variable "aws_region" {
  default = ""

}