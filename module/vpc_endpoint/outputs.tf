output "vpc_endpoint_id" {
  value       = aws_vpc_endpoint.vpc_endpoint.id
  description = "output to display subnet id"
}

output "vpc_endpoint_arn" {
  value = aws_vpc_endpoint.vpc_endpoint.arn
}

output "vpc_endpoint_network_ids" {
  value = aws_vpc_endpoint.vpc_endpoint.network_interface_ids

}