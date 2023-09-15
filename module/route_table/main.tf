
#define traffic to route table with IGW
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id
  dynamic "route" {
    for_each = var.route
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.gateway_id
    }
  }

  tags = {
    Name        = "${var.name} ${var.env} route table"
    Environment = var.env
  }

}
