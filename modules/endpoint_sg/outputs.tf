// modules/endpoint_sg/outputs.tf

output "endpoint_sg_id" {
  description = "ID of the SG for PrivateLink endpoint ENIs"
  value       = aws_security_group.pl_endpoint.id
}