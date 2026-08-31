output "vpc" {
  value = module.VPC.vpc_id
}

output "public_subnet" {
  value = module.VPC.public_subnets
}

output "private_subnet" {
  value = module.VPC.private_subnets
}