output "name" {
  description = "The name of the VPC generated from the module"
  value       = aws_vpc.this.tags.Name
}

