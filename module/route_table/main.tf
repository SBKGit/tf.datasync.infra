
#define traffic to route table with IGW
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id
  route = var.route

  tags = {
    Name        = "${var.name} ${var.env} route table"
    Environment = var.env
  }

}
