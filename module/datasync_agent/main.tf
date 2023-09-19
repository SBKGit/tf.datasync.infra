
resource "aws_datasync_agent" "datasync_agent" {
  ip_address = var.ip_address
  security_group_arns   = var.security_group_arns
  subnet_arns           = var.subnet_arns
  vpc_endpoint_id       = var.vpc_endpoint_id
  private_link_endpoint = tolist(var.vpc_endpoint_ip)[0]
  name                  = "${var.name}_${var.env}_agent"
}