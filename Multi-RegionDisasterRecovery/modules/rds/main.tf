resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
  identifier              = "${var.name}-rds"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name // Reference the subnet group created above
  vpc_security_group_ids  = [var.security_group_id] // Reference the security group passed in as a variable 
  backup_retention_period = 7
  skip_final_snapshot     = true
  multi_az                = true

  tags = {
    Name = "${var.name}-rds"
  }
}

// This resource creates a snapshot of the RDS instance created above. It is used for backup and disaster recovery purposes. The snapshot is created automatically based on the backup retention period specified in the RDS instance.

resource "aws_db_snapshot" "automated" {
  db_snapshot_identifier = "${var.name}-rds-snapshot" // This is the identifier for the snapshot
  db_instance_identifier = aws_db_instance.this.identifier // Reference the RDS instance created above
  depends_on             = [aws_db_instance.this] // Ensure the snapshot is created after the instance
}