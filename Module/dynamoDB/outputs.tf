output "dynamoDB_id" {
  value       = aws_dynamodb_table.dynamoDB.id
  description = "output to display role id"
}

output "dynamoDB_arn" {
  value       = aws_dynamodb_table.dynamoDB.arn
  description = "output to display role id"
}