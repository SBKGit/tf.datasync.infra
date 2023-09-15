# Create a public subnet in VPC1
resource "aws_subnet" "subnet" {
  count = length(var.availability_zone)
  vpc_id     = var.vpc_id
  cidr_block = cidrsubnet(var.subnet_cidr, 8, count.index)
  availability_zone =var.availability_zone[count.index]
  # availability_zone = var.private_subnet_availability_zone
  tags = {
    Name        = "${var.name} - ${var.env} - ${availability_zone[count.index]}"
    Environment = var.env
  }
}