#create elastic IP/Public IP for NAT Gateway
resource "aws_eip" "nat_gateway_eip" {

  tags = {
    Name        = "Nat Gateway eip ${var.name} ${var.env}"
    Environment = var.env
  }
}

#create nat gateway for private subnet 
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = var.subnet_id
  depends_on    = [aws_eip.nat_gateway_eip]
  tags = {
    Name        = "Nat Gateway ${var.name} ${var.env}"
    Environment = var.env
  }

}