output "security_group_id" {
  value       = aws_security_group.security_group.id
  description = "output to display sg id"
}

output "security_group_name" {
  value       = aws_security_group.security_group.name
  description = "output to display sg name"
}

output "security_group_arn" {
  value       = aws_security_group.security_group.arn
  description = "output to display sg arn"
}
