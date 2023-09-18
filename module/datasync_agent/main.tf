
resource "aws_datasync_agent" "datasync_agent" {
  ip_address = var.ip_address
  security_group_arns   = var.security_group_arns
  subnet_arns           = var.subnet_arns
  vpc_endpoint_id       = var.vpc_endpoint_id
  private_link_endpoint = var.vpc_endpoint_ip
  name                  = "${var.name}_${var.env}_agent"
}