output "neptune_subnet_group_ids" {
  value = module.db_subnet_group.neptune_subnet_group_ids
}

output "docdb_subnet_group_ids" {
  value = module.db_subnet_group.docdb_subnet_group_ids
}

output "jenkins_free_instance_id" {
  description = "ID of the Jenkins EC2 instance"
  value       = aws_instance.jenkins_free.id
}

output "jenkins_free_instance_private_ip" {
  description = "Private IP of the Jenkins EC2 instance"
  value       = aws_instance.jenkins_free.private_ip
}

output "network_interface_ids" {
  description = "All EC2-related network interface IDs"
  value = [
    aws_network_interface.eni1.id,
    aws_network_interface.eni2.id,
    aws_network_interface.eni3.id,
    aws_network_interface.eni4.id,
    aws_network_interface.eni5.id,
    aws_network_interface.eni6.id,
    aws_network_interface.eni7.id,
    aws_network_interface.eni8.id,
    aws_network_interface.eni9.id,
    aws_network_interface.eni10.id
  ]
}

output "network_interface_attachment_ids" {
  description = "All network interface attachment resource IDs"
  value = [
    aws_network_interface_attachment.attach1.id,
    aws_network_interface_attachment.attach2.id,
    aws_network_interface_attachment.attach3.id
  ]
}

output "ecr_repository_urls" {
  description = "ECR 리포지토리별 URL"
  value       = module.ecr.repository_urls
}

output "ecr_repository_names" {
  description = "ECR 리포지토리별 이름"
  value       = module.ecr.repository_names
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_nodegroup_asg_name" {
  value = module.eks.nodegroup_asg_name
}

output "iam_role_arns" {
  description = "Map of IAM role ARNs"
  value       = module.iam.role_arns
}

output "iam_policy_arns" {
  description = "Map of IAM policy ARNs"
  value       = module.iam.policy_arns
}

output "iam_instance_profile_names" {
  description = "Map of IAM instance profile names"
  value       = module.iam.instance_profile_names
}

output "iot_thing_names" {
  value = module.iot.thing_names
}

output "iot_certificate_arns" {
  value = module.iot.certificate_arns
}

output "iot_policy_names" {
  value = module.iot.policy_names
}

output "kinesis_stream_arns" {
  description = "Kinesis 스트림 ARNs"
  value       = module.kinesis.stream_arns
}

output "kinesis_stream_names" {
  description = "Kinesis 스트림 이름"
  value       = module.kinesis.stream_names
}

output "lambda_function_arns" {
  value = module.lambda.function_arns
}

output "lambda_function_names" {
  value = module.lambda.function_names
}

output "lightsail_instance_id" {
  value = module.lightsail.instance_id
}

output "lightsail_public_ip" {
  value = module.lightsail.public_ip
}

output "lightsail_private_ip" {
  value = module.lightsail.private_ip
}

output "rds_instance_ids" {
  value = module.rds.db_instance_ids
}

output "rds_subnet_group_names" {
  value = module.rds.db_subnet_group_names
}

output "s3_bucket_names" {
  value = module.s3.bucket_names
}

output "s3_bucket_arns" {
  value = module.s3.bucket_arns
}

output "security_group_ids" {
  description = "모든 SG 이름별 ID"
  value       = module.sg.security_group_ids
}

output "security_group_names" {
  description = "모든 SG 이름"
  value       = module.sg.security_group_names
}

output "sqs_queue_urls" {
  value = module.sqs.queue_urls
}

output "sqs_queue_names" {
  value = module.sqs.queue_names
}

output "vpc_ids" {
  value = module.vpc.vpc_ids
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "route_table_ids" {
  value = module.vpc.route_table_ids
}
