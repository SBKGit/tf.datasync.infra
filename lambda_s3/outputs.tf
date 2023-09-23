output "s3_arn_1" {
  value       = module.s3_bucket_1.s3_arn
  description = "output to display subnet id"
}

output "s3_id_1" {
  value = module.s3_bucket_1.s3_id

}

output "s3_bucket_name_1" {
  value = module.s3_bucket_1.s3_bucket_name

}

output "s3_arn_2" {
  value       = module.s3_bucket_2.s3_arn
  description = "output to display subnet id"
}

output "s3_id_2" {
  value = module.s3_bucket_2.s3_id

}

output "s3_bucket_name_2" {
  value = module.s3_bucket_2.s3_bucket_name

}

output "s3_arn_3" {
  value       = module.s3_bucket_3.s3_arn
  description = "output to display subnet id"
}

output "s3_id_3" {
  value = module.s3_bucket_3.s3_id

}

output "s3_bucket_name_3" {
  value = module.s3_bucket_3.s3_bucket_name

}

output "s3_arn_4" {
  value       = module.s3_bucket_4.s3_arn
  description = "output to display subnet id"
}

output "s3_id_4" {
  value = module.s3_bucket_4.s3_id

}

output "s3_bucket_name_4" {
  value = module.s3_bucket_4.s3_bucket_name

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