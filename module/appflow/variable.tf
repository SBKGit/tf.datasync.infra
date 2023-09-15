variable "aws_region" {
  default = "eu-west-2" #please updated in environment.tfvars for change.
}

variable "env" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "name" {
  default = ""

}

variable "profile_Source_connection_type" {
  default = ""

}

variable "dynamics_instance_url" {
  default = ""

}

variable "organization_name" {
  default = ""

}

variable "client_id" {
  default = ""

}

variable "client_secret" {
  default = ""

}

variable "destination_bucket_name" {
  default = ""

}

variable "destination_bucket_prefix" {
  default = ""

}

variable "destination_output_format" {
  default = ""

}

variable "trigger_type" {
  default = ""

}

variable "connection_mode" {
  default = "Private"

}