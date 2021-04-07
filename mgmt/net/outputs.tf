output "vpc_id" {
  value = module.mgmt_net_vpc.vpc_id
}

output "vpc_cidr" {
  value = module.mgmt_net_vpc.vpc_cidr
}

output "public_subnets" {
  value = module.mgmt_net_vpc.public_subnets
}

output "private_subnets" {
  value = module.mgmt_net_vpc.private_subnets
}
