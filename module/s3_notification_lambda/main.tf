# Conditionally enable or disable S3 notification for the Lambda function
resource "aws_s3_bucket_notification" "s3_lambda_notification" {
  bucket      = var.bucket_id
  eventbridge = var.eventbridge
}