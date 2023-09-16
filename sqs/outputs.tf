output "sqs_arn" {
  value       = module.sqs.sqs_queue_arn
  description = "output to display SQS arn"
}

output "sqs_id" {
  value       = module.sqs.sqs_queue_id
  description = "output to display SQS id"
}

output "sqs_url" {
  value = module.sqs.sqs_queue_url

}