output "db_instance_ids" {
  value = { for k, v in aws_db_instance.this : k => v.id }
}

output "db_subnet_group_names" {
  value = { for k, v in aws_db_subnet_group.this : k => v.name }
}
