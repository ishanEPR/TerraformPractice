provider "aws" {
    region = var.region
    # access_key =var.access_key
    # secret_key = var.secret_key
}
module "devvpc" {
    source            = "../"
    vpc_id            = module.devvpc.vpc_id
    project           = var.project
    environment       = var.environment
    cidr_block        = var.vpc_cidr_block
    availability_zones= var.availability_zones_list
    public_subnets    = var.public_subnets
    private_subnets   = var.private_subnets

  
}