output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = module.qa_vpc.private_subnets
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.qa_vpc.public_subnets
}

