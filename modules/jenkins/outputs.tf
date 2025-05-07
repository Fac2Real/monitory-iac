// modules/jenkins/outputs.tf

output "jenkins_controller_id" {
  description = "ID of the Jenkins controller instance"
  value       = aws_instance.jenkins_controller.id
}
