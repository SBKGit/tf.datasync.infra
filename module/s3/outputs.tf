output "s3_arn" {
  value       = aws_s3_bucket.s3_bucket.arn
  description = "output to display subnet id"
}

output "s3_id" {
  value = aws_s3_bucket.s3_bucket.id

}

output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket_domain_name

}