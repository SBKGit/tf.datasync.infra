variable "filename" {
  default = ""
}
variable "aws_region" {
  default = "eu-west-2"
}
variable "env" {
  default = ""
}

variable "name" {
  default = ""

}

variable "iam_role" {
  default = ""
}

variable "handler_name" {
  default = ""

}

variable "security_group_ids" {
  default = [""]

}

variable "subnet_ids" {
  default = [""]

}

variable "runtime" {
  default = ""

}

variable "environment_variables" {
  description = "A map of environment variables for the Lambda function"
  type        = map(string)
}

variable "timeout" {
  default = 180
  
}

variable "source_code_hash" {
  
}