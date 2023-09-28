output "sqs_valid_file_arn" {
  value       = module.sqs_vaild_file.sqs_queue_arn
  description = "output to display SQS arn"
}

output "sqs_valid_file_name" {
  value = module.sqs_vaild_file.sqs_queue_name

}

output "sqs_valid_file_id" {
  value       = module.sqs_vaild_file.sqs_queue_id
  description = "output to display SQS id"
}

output "sqs_valid_file_url" {
  value = module.sqs_vaild_file.sqs_queue_url

}

output "sqs_invalid_file_name" {
  value = module.sqs_invaild_file.sqs_queue_name

}

output "sqs_invalid_file_arn" {
  value       = module.sqs_invaild_file.sqs_queue_arn
  description = "output to display SQS arn"
}

output "sqs_invalid_file_id" {
  value       = module.sqs_invaild_file.sqs_queue_id
  description = "output to display SQS id"
}

output "sqs_invalid_file_url" {
  value = module.sqs_invaild_file.sqs_queue_url

}

output "sqs_notification_arn" {
  value       = module.sqs_notification.sqs_queue_arn
  description = "output to display SQS arn"
}

output "sqs_notification_id" {
  value       = module.sqs_notification.sqs_queue_id
  description = "output to display SQS id"
}

output "sqs_notification_url" {
  value = module.sqs_notification.sqs_queue_url

}

output "sqs_notification_name" {
  value = module.sqs_notification.sqs_queue_name

}