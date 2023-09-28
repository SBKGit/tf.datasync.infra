
output "event_rule_arn" {
  value = aws_cloudwatch_event_rule.lambda_rule.arn
}

output "event_rule_name" {
  value = aws_cloudwatch_event_rule.lambda_rule.name

}

output "event_rule_id" {
  value = aws_cloudwatch_event_rule.lambda_rule.id

}
