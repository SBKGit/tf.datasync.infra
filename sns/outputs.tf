output "sns_topic_arn" {
  value       = module.sns_topic_data.sns_topic_arn
  description = "output to display SQS arn"
}

output "sns_topic_id" {
  value       = module.sns_topic_data.sns_topic_id
  description = "output to display SQS id"
}

output "sns_topic_sub_valid_file_arn" {
  value       = module.sns_topic_subscription_valid_file.sns_topic_subscription_arn
  description = "output to display SQS arn"
}

output "sns_topic_sub_valid_file_id" {
  value       = module.sns_topic_subscription_valid_file.sns_topic_subscription_id
  description = "output to display SQS id"
}

output "sns_topic_sub_invalid_file_arn" {
  value       = module.sns_topic_subscription_invalid_file.sns_topic_subscription_arn
  description = "output to display SQS arn"
}

output "sns_topic_sub_invalid_file_id" {
  value       = module.sns_topic_subscription_invalid_file.sns_topic_subscription_id
  description = "output to display SQS id"
}