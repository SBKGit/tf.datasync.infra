# Create VPC1 (datasync dev)
resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "VPC1_datasync_${var.env}"
    Environment = var.env
  }
}

# Create a private subnet in VPC1
resource "aws_subnet" "private_subnet_vpc1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.private_subnet_cidr
 # availability_zone = var.private_subnet_availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = "Private Subnet VPC1 ${var.env}"
    Environment = var.env
  }
}

# Create IAM role for DataSync agent in VPC1
resource "aws_iam_role" "datasync_agent_role" {
  name = "DataSyncAgentRole_${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      }
    }]
  })
}



# Attach policies to the DataSync agent role
resource "aws_iam_policy_attachment" "datasync_agent_policy_attachment" {
  name = "DataSyncAgentRole_${var.env}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"  # Replace with appropriate policy ARN
  roles      = [aws_iam_role.datasync_agent_role.name]
}

resource "aws_iam_instance_profile" "datasync_profile" {
  name = "DatasyncAgent_${var.env}"
  role = aws_iam_role.datasync_agent_role.name
}

# Create EC2 instance for DataSync agent in VPC1
resource "aws_instance" "datasync_instance" {
  ami           = var.ami_version
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnet_vpc1.id
  iam_instance_profile = aws_iam_instance_profile.datasync_profile.name
  tags = {
    Name = "DataSync Instance"
    Environment = var.env
  }
}