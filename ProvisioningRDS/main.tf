provider "aws" {
  region = var.aws_region
}

# Call VPC module
module "vpc" {
  source        = "./modules/vpc"
  vpc_cidr_block = var.vpc_cdir_block
  enable_dns     = var.enable_dns
}

# Call Subnet module
module "subnets" {
  source        = "./modules/subnet"
  vpc_id        = module.vpc.vpc_id
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  create_subnets       = var.create_subnets
}

# Call RDS module
module "rds" {
  source        = "./modules/rds"
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.subnets.private_subnets
  db_instance_class = var.db_instance_class
  db_engine         = var.db_engine
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
}