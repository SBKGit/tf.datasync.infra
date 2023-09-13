# Output the Flow ARN for reference
output "appflow_flow_arn" {
  value = aws_appflow_flow.app_flow.arn
}