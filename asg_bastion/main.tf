#backend configuration
terraform {
  backend "s3" {
  }
}

#fetching latest ami from amazon
data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

module "asg_bastion" {
  source            = "../module/auto_scaling_group"
  name              = var.name
  env               = var.env
  aws_region        = var.aws_region
  ami_id            = data.aws_ami.amazon-linux-2.id
  instance_type     = var.instance_type
  key_name          = var.key_name
  public_ip = var.public_ip
  user_data         = "userdata.sh"
  securiy_group_id  = [module.security_group_bastion.security_group_id]
  iam_role_name     = module.iam_role_bastion.iam_role_name
  max_size          = var.max_size
  min_size          = var.min_size
  desired_size      = var.desired_size
  health_check_type = var.health_check_type
  subnet            = data.terraform_remote_state.vpc_1.outputs.public_subnet_id
}

module "iam_role_bastion" {
  source       = "../module/iam_role"
  name         = var.name
  env          = var.env
  aws_region   = var.aws_region
  path_name    = var.path_name
  service_name = var.service_name
  managed_arn  = var.managed_arn

}

module "security_group_bastion" {
  source        = "../module/security_group"
  name          = var.name
  env           = var.env
  aws_region    = var.aws_region
  vpc_id        = data.terraform_remote_state.vpc_1.outputs.vpc_1_id
  ingress_rules = var.ingress_rules
  egress_rules = var.egress_rules

}