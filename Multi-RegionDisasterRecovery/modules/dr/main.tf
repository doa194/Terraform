provider "aws" {
  alias  = "dr"
  region = var.dr_region
}

module "vpc" {
  source     = "../modules/vpc"
  providers  = { aws = aws.dr }
  name       = "dr"
  cidr_block = var.vpc_cidr
  azs        = var.azs
}

resource "aws_security_group" "rds_sg" {
  name        = "dr-rds-sg"
  description = "Allow traffic to RDS"
  vpc_id      = module.vpc.this.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Cross-region snapshot copy
resource "aws_db_snapshot_copy" "dr_snapshot" {
  provider                  = aws.dr
  source_db_snapshot_identifier = var.primary_snapshot_arn
  target_db_snapshot_identifier = "dr-db-snapshot"
  kms_key_id                = null # Update if using encryption
  depends_on                = [module.vpc]
}

# To restore, use this snapshot to launch a new RDS instance in DR

output "dr_snapshot_arn" {
  value = aws_db_snapshot_copy.dr_snapshot.arn
}