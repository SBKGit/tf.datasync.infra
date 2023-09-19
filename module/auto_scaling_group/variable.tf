variable "aws_region" {
  default = "eu-west-2" #please updated in environment.tfvars for change.
}

variable "env" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

#variables for launch template
variable "ami_id" {
  default     = ""
  description = "The AMI from which to launch the instance."
}

variable "instance_type" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "key_name" {
  default     = ""
  description = "The key name to use for the instance."
}

variable "public_ip" {
  default = false
  
}
variable "securiy_group_id" {
  default     = ""
  description = "A list of security group IDs to associate with."

}

variable "volume_device_name" {
  default     = "/dev/sdf"
  description = "The name of the device to mount."
}

variable "volume_size" {
  default     = 8
  description = "The size of the volume in gigabytes."

}

variable "volume_type" {
  default     = "gp3"
  description = "The volume type. Can be one of standard, gp2, gp3, io1, io2, sc1 or st1."

}

variable "ebs_deletion" {
  default     = true
  description = "Whether the volume should be destroyed on instance termination"

}

variable "through_put" {
  default     = null
  description = "The throughput to provision for a gp3 volume in MiB/s (specified as an integer, e.g., 500), with a maximum of 1,000 MiB/s."
}

variable "ipos_value" {
  default     = null
  description = "The amount of provisioned IOPS. This must be set with a volume_type of io1/io2/gp3."

}

variable "enable_encryption" {
  default     = true
  description = "Enables EBS encryption on the volume"

}

#auto scaling group variables 
variable "name" {
  default     = ""
  description = "this is mandatory field which need to be given environment.tf file e.g., dev.tfvars"
}

variable "min_size" {
  default     = 1
  description = "By default it will go with 1 instance"
}

variable "max_size" {
  default     = 1
  description = "By default it will go with 1 instance"
}

variable "desired_size" {
  default     = 1
  description = "By default it will go with 1 instance"
}

variable "health_check_type" {
  default     = "EC2"
  description = "allowed values are EC2 or ELB"
}

variable "health_check_grace_period" {
  default     = 300
  description = "Time (in seconds) after instance comes into service before checking health."
}

variable "health_percentage" {
  default     = 50
  description = "Amount of capacity in the Auto Scaling group that must remain healthy during an instance refresh to allow the operation to continue, as a percentage of the desired capacity of the Auto Scaling group. Defaults to 90"
}

variable "instance_strategy" {
  default     = "Rolling"
  description = "trategy to use for instance refresh. The only allowed value is Rolling"
}

variable "force_delete" {
  default     = false
  description = "Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. You can force an Auto Scaling Group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling."
}

variable "load_balancer_arn" {
  default     = null
  description = "List of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. "

}

variable "target_group_arn" {
  default     = null
  description = "Set of aws_alb_target_group ARNs, for use with Application or Network Load Balancing. To remove all target group attachments an empty list should be specified."

}

variable "subnet" {
  default     = ""
  description = "List of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside"

}

variable "launch_version" {
  default     = "$Latest"
  description = "Template version. Can be version number, $Latest, or $Default."

}

variable "iam_role_name" {
  default = ""

}

variable "user_data" {
  default = ""

}

variable "propagate_at_launch" {
  default = true

}