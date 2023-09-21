#common variables for lambda S3 creation
variable "aws_region" {
  default = ""

}

variable "env" {
  default = ""

}

variable "name" {
  default = ""

}

#bucket creation variables 
variable "bucket_name" {

}

variable "expiration_days" {
  type = number

}

variable "acl" {
  default = ""

}

variable "enable_lifecycle" {
  description = "Enable or disable S3 bucket lifecycle configuration"
  type        = bool
  default     = false
}

#lambda creation variables 

variable "path_name" {

}

variable "managed_arn" {

}

variable "service_name" {

}

#lambda security group variables

variable "handler_name" {

}

variable "runtime" {

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

#variable for email identity

variable "email_addresses" {
  type = list(string)
}

variable "target_type" {

}