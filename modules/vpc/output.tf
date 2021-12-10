output "vpc_id" {
  description = "This the VPC id"
  value       = aws_vpc.this.id


}
output "name" {
  description = "The name of the VPC generated from the module"
  value       = aws_vpc.this.tags.Name
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}