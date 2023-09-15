output "igw_id" {
  value       = aws_internet_gateway.igw.id
  description = "output to display igw id"
}

output "igw_arn" {
  value       = aws_internet_gateway.igw.arn
  description = "output to display subnet arn"
}
