output "sns_topic_arn" {
  value       = aws_sns_topic.sns_topic.arn
  description = "output to display SQS arn"
}

output "sns_topic_id" {
  value       = aws_sns_topic.sns_topic.id
  description = "output to display SQS id"
}