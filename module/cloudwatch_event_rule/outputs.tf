
output "event_rule_arn" {
  value = aws_cloudwatch_event_rule.event_rule.arn
}

output "event_rule_name" {
  value = aws_cloudwatch_event_rule.event_rule.name

}