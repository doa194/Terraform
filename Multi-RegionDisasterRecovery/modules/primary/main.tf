# This module creates a primary region with a VPC, RDS instance, and security group.
# It also creates a snapshot of the RDS instance for backup and disaster recovery purposes.

provider "aws" {
  alias  = "primary" # This provider is used for the primary region
  region = var.primary_region # The region is specified in the variable
}

module "vpc" {
  source     = "../modules/vpc" # This module creates a VPC and subnets 
  # The source path should be updated to the correct location of the VPC module
  providers  = { aws = aws.primary }
  name       = "primary"
  cidr_block = var.vpc_cidr
  azs        = var.azs
}

resource "aws_security_group" "rds_sg" { # This security group allows traffic to the RDS instance
  name        = "primary-rds-sg"
  description = "Allow traffic to RDS"
  vpc_id      = module.vpc.this.id # Reference the VPC created above

  ingress { # Allow incoming traffic on port 3306 (MySQL)
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress { # Allow all outgoing traffic
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "rds" {
  source            = "../modules/rds" # This module creates an RDS instance
  providers         = { aws = aws.primary } # Use the primary provider
  name              = "primary"
  subnet_ids        = module.vpc.public[*].id
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  security_group_id = aws_security_group.rds_sg.id # Reference the security group created above
}

resource "aws_rds_cluster_snapshot" "primary_snapshot" {
  db_cluster_identifier = module.rds.this.id
  db_cluster_snapshot_identifier = "primary-db-snapshot"
}

output "primary_rds_endpoint" {
  value = module.rds.this.endpoint
}