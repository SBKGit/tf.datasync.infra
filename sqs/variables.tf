variable "aws_region" {
  default = ""

}

variable "app_name" {
  default = ""

}

variable "env" {
  default = ""

}

variable "delay_seconds" {
  default     = null
  description = "please provide seconds number only"

}

variable "message_size" {
  default     = null
  description = "please provide in numbers"
}

variable "retention_seconds" {
  default     = null
  description = "please provide retention in seconds"

}

variable "receive_wait_time" {
  default = null

}

# variable "retention_wait_time" {
#   default = null

# }