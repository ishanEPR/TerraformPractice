variable "environment" {
  description = "Environment Name"
  type        = string


}

variable "project" {
  description = "Name of the project"
  type        = string
  default     = "terraform_practice"

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



variable "ami" {

  description = "EC2 instances id(ami)"
}

variable "instance_type" {
  description = "ec2 instance type"

}
