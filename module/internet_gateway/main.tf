#create internet gateway for bastion access
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = {
    Name        = "${var.name} ${var.env} igw"
    Environment = var.env
  }
}