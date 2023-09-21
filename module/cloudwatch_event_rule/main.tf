resource "aws_cloudwatch_event_rule" "event_rule" {
  name          = "${var.name}-${var.env}-rule"
  description   = "This event rule invokes a Lambda function when an event occurs."
  event_pattern = var.event_pattern

  targets {
    arn  = var.target_arn
    id   = var.target_name
    type = var.target_type
  }
}
