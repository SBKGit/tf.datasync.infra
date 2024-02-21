#Landing Zone bucket outputs

output "landing_zone_s3_arn" {
  value       = module.landing_zone_s3.s3_arn
  description = "S3 arn output"
}

output "landing_zone_s3_id" {
  value = module.landing_zone_s3.s3_id

}

output "landing_zone_s3_bucket_name" {
  value = module.landing_zone_s3.s3_bucket_name

}

output "listener_lambda_arn" {
  value = module.lambda_listener.lambda_arn

}

output "scanner_lambda_arn" {
  value = module.lambda_scanner.lambda_arn

}

output "update_file_tag_arn" {
  value = module.lambda_update_file_tag.lambda_arn

}

output "custom_lambda_arn" {
  value = module.lambda_custom.lambda_arn

}