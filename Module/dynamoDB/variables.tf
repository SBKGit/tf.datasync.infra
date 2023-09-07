variable "name" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "env" {
  default = ""
  
}

variable "billing_mode" {
  default     = "PAY_PER_REQUEST"
  description = "You can also use PROVISIONED or PAY_PER_REQUEST"
}

variable "read_capacity" {
  default = ""
  description = "Number of read units for this table. If the billing_mode is PROVISIONED, this field is required."
}

variable "write_capacity" {
  default = ""
  description = "Number of write units for this table. If the billing_mode is PROVISIONED, this field is required."
  
}

variable "encryption" {
  default = true
  description = "Encryption at rest options. AWS DynamoDB tables are automatically encrypted at rest with an AWS-owned Customer Master Key if this argument isn't specified."
  
}