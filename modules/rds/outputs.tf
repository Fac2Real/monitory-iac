output "rds_endpoint" {
  description = "RDS endpoint (hostname)"
  value       = aws_db_instance.this.address
}

output "rds_security_group_id" {
  description = "Security group ID attached to RDS instance"
  value       = aws_security_group.rds.id
}
