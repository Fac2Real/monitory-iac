output "jenkins_free_instance_id" {
  value = aws_instance.jenkins_free.id
}

output "eni_ids" {
  value = { for k, v in aws_network_interface.eni : k => v.id }
}
