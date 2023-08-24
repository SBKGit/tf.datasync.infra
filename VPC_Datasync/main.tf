locals {
  instance_types = {
    dev  = "m5.2xlarge"
    uat  = "m5.2xlarge"
    prod = "m5.2xlarge"
  }
}

# Create IAM role for DataSync agent in VPC1
resource "aws_iam_role" "datasync_instance_role" {
  name = "DataSyncInstanceRole_${terraform.workspace}"
  path = "/app/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      "Principal" : {
        "Service" : [
          "ec2.amazonaws.com"
        ]
      }
    }]
  })
}

# Attach policies to the DataSync agent role
resource "aws_iam_policy_attachment" "datasync_Instance_policy_attachment" {
  name       = "datasync-Instance-${terraform.workspace}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" # Replace with appropriate policy ARN
  roles      = [aws_iam_role.datasync_instance_role.name]
}

# Attach policies to the DataSync agent role SSM policy
resource "aws_iam_policy_attachment" "datasync_ssm_policy_attachment" {
  name       = "datasync-Instance-ssm-${terraform.workspace}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM" # Replace with appropriate policy ARN
  roles      = [aws_iam_role.datasync_instance_role.name]
}

#Attach IAM role to EC2 Machine
resource "aws_iam_instance_profile" "datasync_profile" {
  name = "DatasyncAgent_${terraform.workspace}"
  role = aws_iam_role.datasync_instance_role.name
}

#create security group to allow traffic
resource "aws_security_group" "datasync_security_group" {
  name        = "datasync_security_group_${terraform.workspace}"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc_1.outputs.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]

  }

  tags = {
    Name        = "Datasync security group ${terraform.workspace}"
    Environment = terraform.workspace
  }
}

# Create EC2 instance for DataSync agent in VPC1
resource "aws_instance" "datasync_instance" {
  ami                  = var.ami_version
  instance_type        = local.instance_types[terraform.workspace]
  subnet_id            = data.terraform_remote_state.vpc_1.outputs.private_subnet
  security_groups      = [aws_security_group.datasync_security_group.id]
  iam_instance_profile = aws_iam_instance_profile.datasync_profile.name
  key_name             = "Ec2_keypair"
  user_data = <<-EOF
              #!/bin/bash
              yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
              systemctl start amazon-ssm-agent
              systemctl enable amazon-ssm-agent
              EOF
  tags = {
    Name        = "DataSync Instance"
    Environment = terraform.workspace
  }
}

#create security group to allow traffic
resource "aws_security_group" "datasync_agent_security_group" {
  name        = "datasync_agent_security_group_${terraform.workspace}"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc_1.outputs.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]

  }
}

#Create Data sync agent
resource "aws_vpc_endpoint" "datasync_agent_endpoint" {
  service_name       = "com.amazonaws.${var.aws_region}.datasync"
  vpc_id             = data.terraform_remote_state.vpc_1.outputs.vpc_id
  security_group_ids = [aws_security_group.datasync_agent_security_group.id]
  subnet_ids         = [data.terraform_remote_state.vpc_1.outputs.private_subnet]
  vpc_endpoint_type  = "Interface"
}

resource "aws_datasync_agent" "datasync_agent" {
  ip_address            = aws_instance.datasync_instance.private_ip
  security_group_arns   = [aws_security_group.datasync_agent_security_group.arn]
  subnet_arns           = [data.terraform_remote_state.vpc_1.outputs.private_subnet_arn]
  vpc_endpoint_id       = aws_vpc_endpoint.datasync_agent_endpoint.id
  private_link_endpoint = data.aws_network_interface.datasync_agent_interface.private_ip
  name                  = "example"
}


data "aws_network_interface" "datasync_agent_interface" {
  id = tolist(aws_vpc_endpoint.datasync_agent_endpoint.network_interface_ids)[0]
}