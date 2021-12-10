variable "environment" {
  description = "Environment Name"
  type        = string


}

variable "project" {
  description = "Name of the project"
  type        = string
  default     = "terraform_practice"

}
variable "cluster_name" {
  description = "Name of eks cluster"
  type        = string

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
variable "eks_version" {
  type        = string
  description = "Kubernetes version of eks cluster"
  default     = "1.21"

}

variable "node_groups_configs" {
  description = "Map of node groups to create."

}

variable "eks_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true

}

variable "eks_endpoint_private_access" {


  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = false

}