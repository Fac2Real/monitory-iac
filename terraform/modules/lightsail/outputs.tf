output "instance_id" {
  value = aws_lightsail_instance.this.id
}

output "public_ip" {
  value = aws_lightsail_instance.this.public_ip_address
}

output "private_ip" {
  value = aws_lightsail_instance.this.private_ip_address
}
