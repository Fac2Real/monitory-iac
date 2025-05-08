// modules/vpc/outputs.tf

output "vpc_id" {
  description = "생성된 VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "퍼블릭 서브넷 ID"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "프라이빗 서브넷 ID"
  value       = aws_subnet.private.id
}

output "unused_subnet_id" {
  description = "미사용 서브넷 ID"
  value       = aws_subnet.unused.id
}

output "vpc_cidr_block" {
  description = "VPC CIDR 블록"
  value       = aws_vpc.this.cidr_block
}
