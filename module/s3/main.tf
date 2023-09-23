# Create an S3 bucket in VPC2 for landing zone
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.name}-${var.env}"
  acl    = var.acl
  tags = {
    Name        = "${var.name} ${var.env}"
    Environment = var.env
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_bucket" {
  count  = var.enable_lifecycle ? 1 : 0 # Conditional resource creation
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    id     = "${var.name}-${var.env}-expiry-days"
    status = var.status
    expiration {
      days = var.expiration_days
    }
  }
}

