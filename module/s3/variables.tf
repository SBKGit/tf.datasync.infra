variable "aws_region" {
  default = ""

}

variable "env" {
  default = ""

}

variable "name" {
  default = ""

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


variable "status" {

}