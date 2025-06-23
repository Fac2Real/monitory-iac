output "neptune_subnet_group_ids" {
  value = { for k, v in aws_neptune_subnet_group.this : k => v.id }
}

output "docdb_subnet_group_ids" {
  value = { for k, v in aws_docdb_subnet_group.this : k => v.id }
}
