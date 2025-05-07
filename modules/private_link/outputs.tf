// modules/private_link/outputs.tf

output "iot_data_endpoint_id" {
  description = "ID of the IoT Core Interface Endpoint"
  value       = aws_vpc_endpoint.iot_data.id
}