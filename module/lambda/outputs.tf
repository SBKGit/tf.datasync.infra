output "lambda_arn" {
  value       = aws_lambda_function.lambda.arn
  description = "output to display lambda arn"
}

output "lambda_id" {
  value = aws_lambda_function.lambda.id

}

output "lambda_name" {
  value = aws_lambda_function.lambda.function_name

}