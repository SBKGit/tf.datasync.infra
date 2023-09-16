output "sns_topic_arn" {
  value       = module.sns_vpc2.sns_topic_arn
  description = "output to display SQS arn"
}

output "sns_topic_id" {
  value       = module.sns_vpc2.sns_topic_id
  description = "output to display SQS id"
}