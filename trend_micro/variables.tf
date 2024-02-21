variable "env" {
  default = ""
}

variable "acl" {
    default = "private"
}

variable "aws_region" {
    default = "eu-west-2"
}

variable "landing_zone_status" {
    default = "Enabled"
}

variable "landing_zone_expiration_days" {
    default = number
}

variable "to_process_status" {
    default = "Enabled"
}

variable "to_process_expiration_days" {
    default = number
}

variable "error_zone_status" {
    default = "Enabled"
}

variable "error_zone_expiration_days" {
    default = number
}

