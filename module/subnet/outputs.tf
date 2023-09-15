output "subnet_id" {
  value       = aws_subnet.subnet[*].id
  description = "output to display subnet id"
}

output "subnet_arn" {
  value       = aws_subnet.subnet[*].arn
  description = "output to display subnet arn"
}
