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

output "event_rule_arn" {
  value = module.event_rule.event_rule_arn

}

output "event_rule_name" {
  value = module.event_rule.event_rule_name

}

output "filename_prefix_lambda_arn" {
  value = module.lambda_filename_prefix.lambda_arn
}

output "valid_fufilment_lambda_arn" {
  value = module.valid_fufilment.lambda_arn

}

output "invalid_file_lambda_arn" {
  value = module.invalid_file.lambda_arn

}

output "notification_lambda_arn" {
  value = module.notification.lambda_arn

}