output "start_lambda_arn" {
  value       = module.start_lambda.lambda_arn
  description = "output to display lambda arn"
}

output "stop_lambda_arn" {
  value       = module.stop_lambda.lambda_arn
  description = "output to display lambda arn"
}
