variable "name" {
  default = ""

}

variable "env" {
  default = ""

}

variable "aws_region" {
  default = ""

}

variable "instance_type" {
  default = ""

}

variable "key_name" {
  default = ""

}

variable "max_size" {
  default = ""

}

variable "min_size" {
  default = ""

}

variable "desired_size" {
  default = ""

}

variable "health_check_type" {
  default = "EC2"

}

variable "path_name" {
  default = "/app/"

}

variable "service_name" {
  default = ""

}

variable "managed_arn" {
  default = []

}

variable "ingress_rules" {
  type = map(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
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
    security_groups = list(string)
  }))
  description = "Map of ingress rules"
}


variable "vpc_endpoint_type" {
  default = ""

}

variable "agent_ingress_rules" {
  type = map(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
    }
  ))
  description = "Map of ingress rules"
}

variable "agent_egress_rules" {
  type = map(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
  }))
  description = "Map of ingress rules"
}


