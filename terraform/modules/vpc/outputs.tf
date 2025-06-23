output "vpc_ids" {
  value = { for k, v in aws_vpc.this : k => v.id }
}

output "subnet_ids" {
  value = { for k, v in aws_subnet.this : k => v.id }
}

output "route_table_ids" {
  value = { for k, v in aws_route_table.this : k => v.id }
}
