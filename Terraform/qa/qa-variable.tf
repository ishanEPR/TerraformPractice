variable "region" {default = "ap-south-1"}
variable "access_key" {}
variable "secret_key" {}


variable "environment" {
    description = "Environment Name"
    type = string
    default = "qa"
  
}

variable "project" {
    description = "Name of the project"
    type = string
    default = "terraform_practice"
  
}

variable "vpc_cidr_block" {
    default = "10.20.0.0/16"
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
    default = ["10.20.10.0/24","10.20.11.0/24"]
  
}

variable "private_subnets" {
    description = "private subnets"
    type = list
    default = ["10.20.20.0/24","10.20.21.0/24"]
  
}
variable "ami" {
    default = "ami-0d718c3d715cec4a7"
  
}
variable "instance_type" {
    default="t2.micro"
  
}