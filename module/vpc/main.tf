# Create VPC1 (datasync dev)
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "${var.name}-${var.env}-vpc"
    Environment = var.env
  }
}