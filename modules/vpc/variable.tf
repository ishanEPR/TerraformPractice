variable "environment" {
  description = "Environment Name"
  type        = string


}

variable "project" {
  description = "Name of the project"
  type        = string
  default     = "terraform_practice"

}


variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "Vpc cidr block"

}

variable "availability_zones_list" {
  description = "All the availability Zones List"
  type        = list(any)
  default     = ["ap-south-1a", "ap-south-1b"]

}

variable "public_subnets" {
  description = "public subnets"
  type        = list(any)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]

}

variable "private_subnets" {
  description = "private subnets"
  type        = list(any)
  default     = ["10.0.20.0/24", "10.0.21.0/24"]

}

variable "public_ip_address" {
  default = "0.0.0.0/0"
  type    = String

}

variable "common_tags" {
  description = "Common list of tags"
  type        = map(string)
  default     = {}
}

variable "public_subnet_tags" {
  description = "List of tags to use in public subnet"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "List of tags to use in private subnet"
  type        = map(string)
  default     = {}
}


