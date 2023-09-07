variable "aws_region" {
  default = "eu-west-2" #please updated in environment.tfvars for change.
}
variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "This is for VPC Datasync VPC CIDR IP range"
}

variable "env" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "private_subnet_cidr" {
  default     = "10.0.1.0/24"
  description = "This block is for private subnet CIDR block"
}

variable "egress_cidr" {
  default     = ["0.0.0.0/0"]
  description = "please provide valid CIDR block in IPV4"
}

variable "private_subnet_availability_zone" {
  default     = ["eu-west-2a", "eu-west-2b"] # Replace with your desired AZ
  description = "please provide availability zone "
}

variable "instance_type" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "ami_version" {
  description = "Version of the AMI to deploy by default it will be pick-up"
  type        = string
  default     = ""
}

variable "datasync_task_options" {
  type        = map(string)
  description = "A map of datasync_task options block"
  default = {
    verify_mode            = "POINT_IN_TIME_CONSISTENT"
    posix_permissions      = "NONE"
    preserve_deleted_files = "REMOVE"
    uid                    = "NONE"
    gid                    = "NONE"
    atime                  = "NONE"
    mtime                  = "NONE"
    bytes_per_second       = "-1"
  }
}
