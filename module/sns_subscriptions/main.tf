#create sns topic
resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  topic_arn                       = var.topic_arn
  protocol                        = var.protocol
  endpoint                        = var.endpoint
  confirmation_timeout_in_minutes = var.confirmation_timeout
  endpoint_auto_confirms          = var.auto_confirms

  tags = {
    Name        = var.name
    Environment = var.env
  }
}
