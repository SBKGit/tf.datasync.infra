variable "name" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "aws_region" {
  default = ""

}

variable "env" {
  default = ""

}
variable "managed_arn" {
  default     = ""
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. When configured, Terraform will align the role's managed policy attachments with this set by attaching or detaching managed policies. Configuring an empty set (i.e., managed_policy_arns = []) will cause Terraform to remove all managed policy attachments."
}

variable "path_name" {
  default     = "/app/"
  description = "Path to the role. See IAM Identifiers for more information."
}

variable "service_name" {
  default = ""

}

variable "action_items" {
  default = ""

}