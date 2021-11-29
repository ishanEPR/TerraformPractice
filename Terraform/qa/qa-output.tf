output "vpc_id" {
    description = "This the VPC id"
    value       = module.my_qa_vpc.vpc_id

  
}
output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = module.my_qa_vpc.private_subnets
}