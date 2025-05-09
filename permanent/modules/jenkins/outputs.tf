// modules/jenkins/outputs.tf

output "jenkins_controller_id" {
  description = "ID of the Jenkins controller instance"
  value       = aws_instance.jenkins_controller.id
}

output "jenkins_controller_public_ip" {
  description = "Public IP of the Jenkins controller instance"
  value       = aws_instance.jenkins_controller.public_ip
}

output "jenkins_controller_sg_id" {
  description = "Security group ID of the Jenkins controller"
  value       = aws_security_group.jenkins_sg.id
}
