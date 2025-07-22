resource "aws_db_instance" "main" {
  allocated_storage    = 20
  engine               = var.db_engine
  instance_class       = var.db_instance_class
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name = aws_db_subnet_group.main.name
}

resource "aws_security_group" "rds" {
  name        = "${var.db_name}-rds-sg"
  description = "Allow DB connections"
  vpc_id      = var.vpc_id
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids
}

output "db_endpoint" {
  value = aws_db_instance.main.endpoint
}