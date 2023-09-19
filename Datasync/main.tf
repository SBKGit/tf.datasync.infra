#backend configuration
terraform {
  backend "s3" {
  }
}

#fetching latest ami from amazon
data "aws_ami" "amazon-datasync" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["aws-datasync-*"]
  }
}

module "asg_datasync" {
  source            = "../module/auto_scaling_group"
  name              = var.name
  env               = var.env
  aws_region        = var.aws_region
  ami_id            = data.aws_ami.amazon-datasync.id
  instance_type     = var.instance_type
  key_name          = var.key_name
  user_data         = "userdata.sh"
  securiy_group_id  = [module.security_group_datasync_instance.security_group_id]
  iam_role_name     = module.iam_role_datasync.iam_role_name
  max_size          = var.max_size
  min_size          = var.min_size
  desired_size      = var.desired_size
  health_check_type = var.health_check_type
  subnet            = data.terraform_remote_state.vpc_1.outputs.private_subnet_id
}

module "iam_role_datasync" {
  source       = "../module/iam_role"
  name         = var.name
  env          = var.env
  aws_region   = var.aws_region
  path_name    = var.path_name
  service_name = var.service_name
  managed_arn  = var.managed_arn

}

module "security_group_datasync_instance" {
  source        = "../module/security_group"
  name          = "${var.name}-instance"
  env           = var.env
  aws_region    = var.aws_region
  vpc_id        = data.terraform_remote_state.vpc_1.outputs.vpc_1_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules

}

module "vpc_endpoint" {
  source            = "../module/vpc_endpoint"
  aws_region        = var.aws_region
  name              = var.name
  env               = var.env
  vpc_id            = data.terraform_remote_state.vpc_1.outputs.vpc_1_id
  security_group    = [module.security_group_endpoint.security_group_id]
  subnet_id         = data.terraform_remote_state.vpc_1.outputs.private_subnet_id
  vpc_endpoint_type = var.vpc_endpoint_type

}

module "security_group_endpoint" {
  source        = "../module/security_group"
  name          = "${var.name}_endpoint"
  env           = var.env
  aws_region    = var.aws_region
  vpc_id        = data.terraform_remote_state.vpc_1.outputs.vpc_1_id
  ingress_rules = var.agent_ingress_rules
  egress_rules  = var.agent_egress_rules

}

data "aws_instance" "datasync" {
  depends_on = [module.asg_datasync]
  filter {
    name   = "tag:Name"
    values = ["${var.name} ${var.env}"]
  }
}

data "aws_network_interface" "datasync_agent" {
  id = tolist(module.vpc_endpoint.vpc_endpoint_network_ids)[0]
}


module "datasync_agent" {
  source     = "../module/datasync_agent"
  name       = "${var.name}-agent"
  env        = var.env
  aws_region = var.aws_region
  #  ip_address          = data.aws_instance.datasync.private_ip
  ip_address          = data.aws_instance.datasync.private_ip
  vpc_endpoint_id     = module.vpc_endpoint.vpc_endpoint_id
  security_group_arns = [module.security_group_endpoint.security_group_arn]
  subnet_arns         = tolist(data.terraform_remote_state.vpc_1.outputs.private_subnet_arn)[0]
  vpc_endpoint_ip     = data.aws_network_interface.datasync_agent.private_ip

}
