# Create a public subnet in VPC1
resource "aws_subnet" "subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr
  # availability_zone = var.private_subnet_availability_zone
  tags = {
    Name        = var.name
    Environment = var.env
  }
}