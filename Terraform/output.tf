output "vpc_id" {
    description = "This the VPC id"
    value       = aws_vpc.this.id

  
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.id
}