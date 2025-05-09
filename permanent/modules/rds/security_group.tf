// modules/rds/security_group.tf

# 1) Security Group for RDS: allow 3306 from allowed SGs (e.g., Jenkins)
resource "aws_security_group" "rds" {
  name        = var.rds_sg_name
  description = "RDS MySQL access"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = var.allowed_sg_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_sg_name
  }
}
