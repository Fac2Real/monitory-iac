output "cluster_id" {
  value = aws_eks_cluster.this.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "nodegroup_asg_name" {
  value = aws_autoscaling_group.nodegroup.name
}
