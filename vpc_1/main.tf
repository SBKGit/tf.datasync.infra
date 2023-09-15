#backend configuration
terraform {
  backend "s3" {
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc_1" {
  source   = "../module/vpc"
  vpc_cidr = var.vpc_cidr
  name     = var.vpc_name
  env      = var.env
  aws_region = var.aws_region

}

module "igw_1" {
  source     = "../module/internet_gateway"
  vpc_id     = module.vpc_1.vpc_id
  name       = var.vpc_name
  env        = var.env
  aws_region = var.aws_region
}

module "private_subnet" {
  source                  = "../../module/subnet"
  name                    = var.private_subnet_name
  env                     = var.env
  aws_region              = var.aws_region
  availability_zone       = data.aws_availability_zones.available.names
  subnet_cidr             = var.private_cidr_block
  vpc_id                  = module.vpc_1.vpc_id
}

module "public_subnet" {
  source                  = "../module/subnet"
  name                    = var.private_subnet_name
  env                     = var.env
  aws_region              = var.aws_region
  availability_zone       = data.aws_availability_zones.available.names
  subnet_cidr             = var.public_cidr_block
  vpc_id                  = module.vpc_1.vpc_id
}

module "nat_gateway" {
  source     = "../module/nat_gateway"
  subnet_id  = module.private_subnet.subnet_id
  name       = var.vpc_name
  aws_region = var.aws_region
  env        = var.env

}

module "public_route_table" {
  source     = "../module/route_table"
  name       = var.vpc_name
  aws_region = var.aws_region
  env        = var.env
  route = [ {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.igw_1.igw_id
  },
  {
    cidr_block = var.vpc_cidr
    gateway_id = "local"

  } ]
}

module "private_route_table" {
  source     = "../module/route_table"
  name       = var.vpc_name
  aws_region = var.aws_region
  env        = var.env
  route = [{
    cidr_block = "0.0.0.0/0"
    gateway_id = module.nat_gateway.nat_id
  },
 {
    cidr_block = var.vpc_cidr
    gateway_id = "local"

  }]
}


#subnet association with route table
resource "aws_route_table_association" "public_subnet" {
  count          = length(module.public_subnet.subnet_id)
  subnet_id      = aws_subnet.public_subnet_vpc1.id[count.index]
  route_table_id = module.igw_1.igw_id
}

#subnet association with route table
resource "aws_route_table_association" "private_subnet" {
  count          = length(module.private_subnet.subnet_id)
  subnet_id      = module.private_subnet.subnet_id[count.index]
  route_table_id = module.nat_gateway.nat_id
}