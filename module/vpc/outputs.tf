output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "output to display subnet id"
}

output "vpc_arn" {
  value       = aws_vpc.vpc.arn
  description = "output to display subnet arn"
}
