provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "qa_vpc" {
  source             = "../../modules/vpc/."
  project            = var.project
  environment        = var.environment
  cidr_block         = var.vpc_cidr_block
  availability_zones = var.availability_zones_list
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets

}

# module "dev_ec2" {
#   source        = "../../modules/ec2/."
#   subnet_id     = module.qa_vpc.private_subnets
#   instance_type = var.instance_type
#   ami           = var.ami

# }

module "dev_eks" {

  source              = "../../modules/eks/."
  environment         = var.environment
  project             = var.project
  cluster_name        = var.cluster_name
  eks_version         = var.eks_version
  subnet_ids          = module.qa_vpc.public_subnets
  node_groups_configs = var.node_groups_configs

}