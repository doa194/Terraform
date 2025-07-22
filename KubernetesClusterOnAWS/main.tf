# Specify the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Call VPC module
module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = var.vpc_cidr_block
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs
}

# Call EKS module
module "eks" {
  source           = "./modules/eks"
  cluster_name     = var.cluster_name
  subnet_ids       = module.vpc.private_subnets // Use private subnets for the EKS cluster
  kubernetes_version = var.kubernetes_version // Specify the Kubernetes version
}

# Call Node Group module
module "node_group" {
  source           = "./modules/node-group"
  cluster_name     = module.eks.cluster_name
  subnet_ids       = module.vpc.private_subnets
  node_group_name  = var.node_group_name
  instance_type    = var.instance_type
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size
  node_role_arn    = module.eks.node_group_role_arn
}