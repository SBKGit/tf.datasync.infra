output "vpc_id" {
  value       = aws_vpc.vpc1.id
  description = "This is vpc id."
}
output "enable_dns_support" {
  value       = aws_vpc.vpc1.enable_dns_support
  description = "Check whether dns support is enabled for VPC."
}
output "enable_dns_hostnames" {
  value       = aws_vpc.vpc1.enable_dns_hostnames
  description = "Check whether dns hostname is enabled for VPC."
}
output "aws_internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "Internet gateway id."
}
output "igw_aws_account" {
  value = aws_internet_gateway.igw.owner_id

}
output "private_subnet" {
  value = aws_subnet.private_subnet_vpc1.id

}

output "private_subnet_arn" {
  value = aws_subnet.private_subnet_vpc1.arn

}

output "public_subnet" {
  value = aws_subnet.public_subnet_vpc1.id

}
output "public_subnet_arn" {
  value = aws_subnet.public_subnet_vpc1.arn

}