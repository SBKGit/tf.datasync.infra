resource "aws_cloudwatch_event_rule" "lambda_rule" {
  name                = "${var.name}-${var.env}-rule"
  description         = "Triggers a Lambda function on weekdays"
  schedule_expression = var.cron_expression
  #state = var.state
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.lambda_rule.name
  arn  = var.lambda_arn
}