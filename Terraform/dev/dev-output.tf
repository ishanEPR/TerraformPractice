output "vpc_id" {
    description = "This the VPC id"
    value       = module.devvpc.vpc_id

  
}
output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = module.devvpc.private_subnets
}