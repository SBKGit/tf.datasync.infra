locals {
  instance_types = {
    dev = "t2.medium"
  }
}

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

# Create VPC1 (datasync dev)
resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "VPC1_${terraform.workspace}"
    Environment = terraform.workspace
  }
}

#create internet gateway for bastion access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name        = "igw_${terraform.workspace}"
    Environment = terraform.workspace
  }
}

#create elastic IP/Public IP for NAT Gateway
resource "aws_eip" "nat_gateway_eip" {

  tags = {
    Name        = "Nat Gateway ${terraform.workspace}"
    Environment = terraform.workspace
  }
}

#create nat gateway for private subnet 
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id = aws_subnet.public_subnet_vpc1.id
  depends_on = [aws_eip.nat_gateway_eip]
}

#define traffic to route table with IGW
resource "aws_route_table" "route_table_igw" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"

  }
  tags = {
    Name        = "igw_${terraform.workspace}"
    Environment = terraform.workspace
  }

}

#define traffic to route table for nat gateway
resource "aws_route_table" "route_table_nat" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"

  }
  tags = {
    Name        = "nat_gateway_${terraform.workspace}"
    Environment = terraform.workspace
  }

}

# Create a private subnet in VPC1
resource "aws_subnet" "private_subnet_vpc1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.private_subnet_cidr
  # availability_zone = var.private_subnet_availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name        = "Private Subnet VPC1 ${terraform.workspace}"
    Environment = terraform.workspace
  }
}

#subnet association with route table
resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet_vpc1.id
  route_table_id = aws_route_table.route_table_igw.id
}

#subnet association with route table
resource "aws_route_table_association" "private_subnet" {
  subnet_id      = aws_subnet.private_subnet_vpc1.id
  route_table_id = aws_route_table.route_table_nat.id
}

# Create a public subnet in VPC1
resource "aws_subnet" "public_subnet_vpc1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.public_subnet_cidr
  # availability_zone = var.private_subnet_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name        = "Public Subnet VPC1 ${terraform.workspace}"
    Environment = terraform.workspace
  }
}

# Create IAM role for DataSync agent in VPC1
resource "aws_iam_role" "bastion_instance_role" {
  name = "bastion_${terraform.workspace}"
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
resource "aws_iam_policy_attachment" "bastion_instance_policy_attachment" {
  name       = "bastion-Instance-${terraform.workspace}"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # Replace with appropriate policy ARN
  roles      = [aws_iam_role.bastion_instance_role.name]
}

#Attach IAM role with EC2 machine
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion_${terraform.workspace}"
  role = aws_iam_role.bastion_instance_role.name
}

#create security group to allow traffic
resource "aws_security_group" "bastion_security_group" {
  name        = "bastion_security_group_${terraform.workspace}"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr

  }

  tags = {
    Name        = "bastion security group ${terraform.workspace}"
    Environment = terraform.workspace
  }
}

# Create EC2 instance for DataSync agent in VPC1
resource "aws_instance" "bastion_instance" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = local.instance_types[terraform.workspace]
  subnet_id                   = aws_subnet.public_subnet_vpc1.id
  vpc_security_group_ids      = [aws_security_group.bastion_security_group.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.bastion_profile.name
  key_name                    = "Ec2_keypair"
  user_data                   = <<-EOF
              #!/bin/bash
              yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
              systemctl start amazon-ssm-agent
              systemctl enable amazon-ssm-agent
              sudo yum install -y git
              sudo yum install -y yum-utils shadow-utils
              sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
              sudo yum install -y terraform
              EOF
  tags = {
    Name        = "bastion Instance ${terraform.workspace}"
    Environment = terraform.workspace
  }
}
