output "vpc_id" {
  value       = aws_vpc.vpc2.id
  description = "This is vpc id."
}
output "enable_dns_support" {
  value       = aws_vpc.vpc2.enable_dns_support
  description = "Check whether dns support is enabled for VPC."
}
output "enable_dns_hostnames" {
  value       = aws_vpc.vpc2.enable_dns_hostnames
  description = "Check whether dns hostname is enabled for VPC."
}
output "aws_internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "Internet gateway id."
}

output "public_subnet" {
  value       = aws_subnet.public_subnet_vpc.id
 
}

output "public_subnet_arn" {
  value       = aws_subnet.public_subnet_vpc.arn
 
}

output "s3_bucket_1_id" {
  value       = aws_s3_bucket.landing_zone_bucket_1.id
 
}

output "s3_bucket_1_arn" {
  value       = aws_s3_bucket.landing_zone_bucket_1.arn
 
}

output "s3_bucket_1_url" {
  value       = aws_s3_bucket.landing_zone_bucket_1.bucket_domain_name
 
}

output "s3_bucket_2_id" {
  value       = aws_s3_bucket.landing_zone_bucket_2.id
 
}

output "s3_bucket_2_arn" {
  value       = aws_s3_bucket.landing_zone_bucket_2.arn
 
}

output "s3_bucket_2_url" {
  value       = aws_s3_bucket.landing_zone_bucket_2.bucket_domain_name
 
}

output "s3_bucket_3_id" {
  value       = aws_s3_bucket.landing_zone_bucket_3.id
 
}

output "s3_bucket_3_arn" {
  value       = aws_s3_bucket.landing_zone_bucket_3.arn
 
}

output "s3_bucket_3_url" {
  value       = aws_s3_bucket.landing_zone_bucket_3.bucket_domain_name
 
}

output "lambda_function_arn" {
  value       = aws_lambda_function.transfer_lambda.arn
 
}

output "lambda_function_invoke_arn" {
  value       = aws_lambda_function.transfer_lambda.invoke_arn
 
}

output "lambda_role_arn" {
  value       = aws_iam_role.lambda_role.arn
 
}

output "sqs_queue_arn" {
  value       = aws_sqs_queue.terraform_queue.arn
}

output "sqs_queue_url" {
  value       = aws_sqs_queue.terraform_queue.url
}

output "sqs_deadletter_queue_arn" {
  value       = aws_sqs_queue.deadletter_queue.arn
}

