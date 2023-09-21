output "vpc_2_id" {
  value = module.vpc_2.vpc_id
}

output "igw_2_id" {
  value = module.igw_2.igw_id

}

output "private_subnet_id" {
  value = module.private_subnet.subnet_id

}

output "public_subnet_id" {
  value = module.public_subnet.subnet_id

}

output "nat_gateway_id" {
  value = module.nat_gateway.nat_id

}
