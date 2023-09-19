#create launch templete for auto scaling group
resource "aws_launch_template" "launch_tmpl" {
  name_prefix   = "${var.name}-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  network_interfaces {
    associate_public_ip_address = var.public_ip
    security_groups             = var.securiy_group_id
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.instance_profile.name
  }
  user_data = filebase64("${var.user_data}")
  block_device_mappings {

    device_name = var.volume_device_name
    ebs {
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      delete_on_termination = var.ebs_deletion
      throughput            = var.through_put
      iops                  = var.ipos_value
      encrypted             = var.enable_encryption
    }
  }
  tags = {
    Name        = "${var.name} ${var.env}"
    Environment = var.env
  }
}


#Attach IAM role with EC2 machine
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.name}-${var.env}-instance-profile"
  role = var.iam_role_name
}


#create auto scaling group
resource "aws_autoscaling_group" "asg" {
  name                      = "${var.name}-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  force_delete              = var.force_delete
  load_balancers            = var.load_balancer_arn
  target_group_arns         = var.target_group_arn
  vpc_zone_identifier       = var.subnet
  launch_template {
    id      = aws_launch_template.launch_tmpl.id
    version = var.launch_version
  }
  instance_refresh {
    strategy = var.instance_strategy
    preferences {
      min_healthy_percentage = var.health_percentage
    }
    triggers = ["tag"]
  }

  tag {
    key                 = "Environment"
    value               = var.env
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name} ${var.env}"
    propagate_at_launch = true
  }
}

