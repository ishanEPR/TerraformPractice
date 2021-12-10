output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = module.dev_vpc.private_subnets
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.dev_vpc.public_subnets
}

