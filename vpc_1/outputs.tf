output "vpc_1_id" {
  value = module.vpc_1.vpc_id
}

output "igw_1_id" {
  value = module.igw_1.igw_id

}

output "private_subnet_id" {
  value = module.private_subnet.subnet_id

}

output "public_subnet_id" {
  value = module.public_subnet.subnet_id

}

output "private_subnet_arn" {
  value = module.private_subnet.subnet_arn

}

output "public_subnet_arn" {
  value = module.public_subnet.subnet_arn

}

output "nat_gateway_id" {
  value = module.nat_gateway.nat_id

}
