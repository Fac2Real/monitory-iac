// modules/rds/main.tf

# Subnet group (single AZ, free tier)
resource "aws_db_subnet_group" "rds" {
  name       = "monitory-rdb-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "monitory-rdb-subnet-group"
  }
}

# Parameter group (default params, MySQL 8.0)
resource "aws_db_parameter_group" "mysql8" {
  name        = "monitory-mysql8-params"
  family      = "mysql8.0"
  description = "Custom params for MySQL 8.0"
}

# RDS instance
resource "aws_db_instance" "this" {
  identifier             = var.db_identifier
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.41"
  instance_class         = "db.t4g.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = aws_db_parameter_group.mysql8.name
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  availability_zone      = "ap-northeast-2a"
  port                   = 3306
  deletion_protection    = false
  skip_final_snapshot    = true
  apply_immediately      = true

  tags = {
    Name = var.db_identifier
  }
}
