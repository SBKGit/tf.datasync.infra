output "sqs_queue_arn" {
  value       = aws_sqs_queue.sqs_queue.arn
  description = "output to display SQS arn"
}

output "sqs_queue_id" {
  value       = aws_sqs_queue.sqs_queue.id
  description = "output to display SQS id"
}

output "sqs_queue_url" {
  value       = aws_sqs_queue.sqs_queue.url
  description = "output to display sqs url"
}

output "sqs_queue_name" {
  value = aws_sqs_queue.sqs_queue.name
}