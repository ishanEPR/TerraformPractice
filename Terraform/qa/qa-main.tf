provider "aws" {
    region =var.region
    # access_key =var.access_key
    # secret_key = var.secret_key
  
}

module "myqavpc" {
    source             = "../."
    cidr_block        = var.vpc_cidr_block
    project            =var.project
    environment        =var.environment
    vpc_id             =module.myqavpc.vpc_id
    availability_zones =var.availability_zones_list
    private_subnets    =var.private_subnets
    public_subnets     =var.public_subnets


    
}