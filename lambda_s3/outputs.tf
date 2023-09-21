output "s3_arn" {
  value       = module.s3_bucket.s3_arn
  description = "output to display subnet id"
}

output "s3_id" {
  value = module.s3_bucket.s3_id

}

output "s3_bucket_name" {
  value = module.s3_bucket.s3_bucket_name

}

output "lambda_iam_role" {
  value = module.lambda_iam_role.iam_role_arn

}

output "event_rule_arn" {
  value = module.event_rule.event_rule_arn

}

output "event_rule_name" {
  value = module.event_rule.event_rule_name

}