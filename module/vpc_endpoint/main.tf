#Create Data sync agent
resource "aws_vpc_endpoint" "vpc_endpoint" {
  service_name       = "com.amazonaws.${var.aws_region}.datasync"
  vpc_id             = var.vpc_id
  security_group_ids = var.security_group
  subnet_ids         = var.subnet_id
  vpc_endpoint_type  = var.vpc_endpoint_type
  tags = {
    Name        = "${var.name} ${var.env}"
    Environment = var.env
  }
}