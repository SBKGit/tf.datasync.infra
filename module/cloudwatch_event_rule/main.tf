resource "aws_cloudwatch_event_rule" "event_rule" {
  name          = "${var.name}-${var.env}-rule"
  description   = "This event rule invokes a Lambda function when an event occurs."
  event_pattern = var.event_pattern

}


resource "aws_cloudwatch_event_target" "s3_put_object_event_target" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = var.target_id
  arn       = var.target_arn
}
