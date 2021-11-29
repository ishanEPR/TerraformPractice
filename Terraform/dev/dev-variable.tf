variable "region" {default = "ap-south-1"}

variable "environment" {
    description = "Environment Name"
    type = string
    default = "dev"
  
}

variable "project" {
    description = "Name of the project"
    type = string
    default = "terraform_practice"
  
}

variable "vpc_cidr_block" {
    default = "10.10.0.0/16"
    description = "Vpc cidr block"
  
}

variable "availability_zones_list" {
    description = "All the availability Zones List"
    type = list
    default = ["ap-south-1a","ap-south-1b"]
  
}

variable "public_subnets" {
    description = "public subnets"
    type = list
    default = ["10.10.10.0/24","10.10.11.0/24"]
  
}

variable "private_subnets" {
    description = "private subnets"
    type = list
    default = ["10.10.20.0/24","10.10.21.0/24"]
  
}

