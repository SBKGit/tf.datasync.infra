output "sns_topic_subscription_arn" {
  value       = aws_sns_topic_subscription.sns_topic_subscription.arn
  description = "output to display SQS arn"
}

output "sns_topic_subscription_id" {
  value       = aws_sns_topic_subscription.sns_topic_subscription.id
  description = "output to display SQS id"
}

output "sns_pending_confirmation" {
  value = aws_sns_topic_subscription.sns_topic_subscription.pending_confirmation
}

output "confirmation_authenticated" {
  value = aws_sns_topic_subscription.sns_topic_subscription.confirmation_was_authenticated

}