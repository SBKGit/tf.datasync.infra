variable "aws_region" {
  default = ""

}

variable "name" {
    default = ""
  
}

variable "env" {
    default = ""
  
}

variable "delay_seconds" {
    default = number
    description = "please provide seconds number only"
  
}

variable "message_size" {
    default = number
    description = "please provide in numbers"
}

variable "retention_seconds" {
    default = number
    description = "please provide retention in seconds"
  
}

variable "receive_wait_time" {
    default = number
  
}

variable "deadletter_sqs_arn" {
    default = null
  
}

variable "deadletter_receive_count" {
    default = null
  
}