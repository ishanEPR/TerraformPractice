locals {
  eks_cluster_name = join("-", [var.environment, var.project, var.cluster_name])
}

resource "aws_eks_cluster" "eks" {
  name     = local.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids              = var.public_subnets
    endpoint_public_access  = var.eks_endpoint_public_access
    endpoint_private_access = var.eks_endpoint_private_access

  }




}

resource "aws_eks_node_group" "node_group" {

  for_each = var.node_groups_configs

  cluster_name    = local.eks_cluster_name
  node_group_name = join("-", [var.environment, var.project, each.key, "ng"])
  node_role_arn   = aws_iam_role.eks_cluster_node_role.arn
  subnet_ids      = var.public_subnets

  scaling_config {
    desired_size = lookup(each.value, "desired_size", 1)
    max_size     = lookup(each.value, "max_size", 2)
    min_size     = lookup(each.value, "min_size", 1)
  }

  update_config {
    max_unavailable = lookup(each.value, "max_unavailable", 1)

  }

  depends_on = [
    aws_eks_cluster.eks,
    aws_iam_role.eks_cluster_node_role

  ]




}