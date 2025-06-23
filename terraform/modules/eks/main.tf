resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.cluster_version
  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_launch_template" "nodegroup" {
  name                   = var.nodegroup_launch_template_name
  vpc_security_group_ids = var.nodegroup_security_group_ids
  key_name               = var.nodegroup_key_name
  instance_type          = var.nodegroup_instance_type
}

resource "aws_autoscaling_group" "nodegroup" {
  name                      = var.nodegroup_asg_name
  min_size                  = var.nodegroup_min_size
  max_size                  = var.nodegroup_max_size
  desired_capacity          = var.nodegroup_desired_capacity
  vpc_zone_identifier       = var.nodegroup_subnet_ids
  launch_template {
    id      = aws_launch_template.nodegroup.id
    version = "$Latest"
  }
  tag {
    key                 = "eks:cluster-name"
    value               = var.cluster_name
    propagate_at_launch = true
  }
  tag {
    key                 = "eks:nodegroup-name"
    value               = var.nodegroup_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_lifecycle_hook" "launch" {
  name                  = "Launch-LC-Hook"
  autoscaling_group_name = aws_autoscaling_group.nodegroup.name
  notification_target_arn = var.lifecycle_hook_sns_arn
  heartbeat_timeout     = 1800
  default_result        = "CONTINUE"
  lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
}

resource "aws_autoscaling_lifecycle_hook" "terminate" {
  name                  = "Terminate-LC-Hook"
  autoscaling_group_name = aws_autoscaling_group.nodegroup.name
  notification_target_arn = var.lifecycle_hook_sns_arn
  heartbeat_timeout     = 1800
  default_result        = "CONTINUE"
  lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
}

resource "aws_launch_template" "nodegroup" {
  name = "eks-accbbb09-7b13-ef6f-22bf-51d8a0cc6f52"

  dynamic "tag_specifications" {
    for_each = [
      {
        resource_type = "volume"
        tags = {
          "eks:nodegroup-name" = "monitory-eks-node"
          "eks:cluster-name"   = "monitory-eks-cluster"
        }
      },
      {
        resource_type = "instance"
        tags = {
          "eks:nodegroup-name" = "monitory-eks-node"
          "eks:cluster-name"   = "monitory-eks-cluster"
        }
      },
      {
        resource_type = "network-interface"
        tags = {
          "eks:nodegroup-name" = "monitory-eks-node"
          "eks:cluster-name"   = "monitory-eks-cluster"
        }
      }
    ]
    content {
      resource_type = tag_specifications.value.resource_type
      tags          = tag_specifications.value.tags
    }
  }

  user_data = "TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSIvLyIKCi0tLy8KQ29udGVudC1UeXBlOiBhcHBsaWNhdGlvbi9ub2RlLmVrcy5hd3MKCi0tLQphcGlWZXJzaW9uOiBub2RlLmVrcy5hd3MvdjFhbHBoYTEKa2luZDogTm9kZUNvbmZpZwpzcGVjOgogIGNsdXN0ZXI6CiAgICBhcGlTZXJ2ZXJFbmRwb2ludDogaHR0cHM6Ly85NDczODEwM0ZGMUY1QUE1NzJEOEEyNTAwNzEwRTY4Ny5ncjcuYXAtbm9ydGhlYXN0LTIuZWtzLmFtYXpvbmF3cy5jb20KICAgIGNlcnRpZmljYXRlQXV0aG9yaXR5OiBMUzB0TFMxQ1JVZEpUaUJEUlZKVVNVWkpRMEZVUlMwdExTMHRDazFKU1VSQ1ZFTkRRV1V5WjBGM1NVSkJaMGxKWmxkNVNYUldRWFpHYVUxM1JGRlpTa3R2V2tsb2RtTk9RVkZGVEVKUlFYZEdWRVZVVFVKRlIwRXhWVVVLUVhoTlMyRXpWbWxhV0VwMVdsaFNiR042UVdWR2R6QjVUbFJCTWsxVVFYaE5la1Y0VFhwc1lVWjNNSHBPVkVFeVRVUm5lRTE2UlRKTmVteGhUVUpWZUFwRmVrRlNRbWRPVmtKQlRWUkRiWFF4V1cxV2VXSnRWakJhV0UxM1oyZEZhVTFCTUVkRFUzRkhVMGxpTTBSUlJVSkJVVlZCUVRSSlFrUjNRWGRuWjBWTENrRnZTVUpCVVVSUWRUSnJMekJzVkZvMWVreEZSRXBGVUZScVFtVktNMDVxVm5GMWNtbHlOVUpGVWtOak1uZGpRbmhZVEVGc1JXaElaRkJEZGtrMVpYRUtjMHhWV0hKeGNVWlFjbWN4U2pOalpVVmlUbTFLYUhGelR6QTNZVFZEYzNFNE1FRmpNRWxLZEZjclNYTnhTbGxITVVacFpra3lRVkZLZDA4eGFWRklUQXBXUkVwNlNXMTBhbVY2UVdneFpHYzFNamxwZVdKcFNGUktUWFJXWTNjMGNEVnVSRFpRZURadWIyWnBibEpGTUhVMmREQTFWbWh1Ym1KVk5FaFhTMVJwQ2tnMk9GSnNPRkU0YlRCSlRpOUZVV1kzZEZKR05HMTZOVEpoTUhKUE4xQXdVSFF5SzBwVk5HODFPSGxSUlcxeVUzUlNUMGgwTnpKR1VDOVlRa1ZtVTBJS1ZsbGtNbTU1TjNkbGFqUlZNeXRQTDB0d1dVWkxWbFJGVjNSaFZqaG9ia1ZFZEVaMmVGTkxUbFEyVldWUFZGQkRVREJCVFdsMFVIQXdkV3BVUVZKdWRRb3dOams1YjBKR1RuRnhabmx1YTJabmNtSkdiR2RZWWtsNFJFTXhRV2ROUWtGQlIycFhWRUpZVFVFMFIwRXhWV1JFZDBWQ0wzZFJSVUYzU1VOd1JFRlFDa0puVGxaSVVrMUNRV1k0UlVKVVFVUkJVVWd2VFVJd1IwRXhWV1JFWjFGWFFrSlNOa3R4U1RSaU5ITm5iRWRRV1daQ1l6VklNM0Z3UVdsUWFIaDZRVllLUW1kT1ZraFNSVVZFYWtGTloyZHdjbVJYU214amJUVnNaRWRXZWsxQk1FZERVM0ZIVTBsaU0wUlJSVUpEZDFWQlFUUkpRa0ZSUVhkeGFETnFSMHA0UlFvMVpuZHZObmQzWVVWSFVIUTVNak5HTHpkallVOXBXbVE1VW0xMFRFNXRja0ZIT0ZSQ1l6RjJZbHAzTVRsd2NqSmFiRFY1WTA1M2VTdDNTWGw2U1V4UENsTnVXVmN5WnpSRU5sTjZiVTl5WlVWelUydENNREppYzFsaFNYZDBUMmhzYUVOdGNHbHBNV053UW05V1l6aDJiRFJZV0dKWVkxZG9kRzVSWVU5ck5HUUtjWEJyY1RkQlFuZG1RVFl6UXpWeE1XRjFZMmRhTHl0eWRsWjJiaXM0YW00cmQzcFVOamcxY0RobVdIQm1ObGRNT1hSTFQyOW9jR1ZPYkN0MFMwNUpSQXBYVW1sYWRXNHZWVmhSYm1WSFQzQTBXSFpzT0dWRFIzaFBWM0JYUTBVMWRuZGxUSEphU2xsdGRVVXZaalJ4V0V3elJVMUZWWE5MVVc5UmEwY3ZWMmwyQ2paeFozbHNlRXBwWWxGU05HbzRTRXByWVN0TWVITXZiV1ZRYWtsUk0wcEZRMHhoZFZKa1JVUnhkRzFLTUVoWVVWcE9OSHB0TVVNdlNqaE1OVkEyWW1JS1pXeE1PVTVRTURoMk0yMW1DaTB0TFMwdFJVNUVJRU5GVWxSSlJrbERRVlJGTFMwdExTMEsKICAgIGNpZHI6IDEwLjEwMC4wLjAvMTYKICAgIG5hbWU6IG1vbml0b3J5LWVrcy1jbHVzdGVyCiAga3ViZWxldDoKICAgIGNvbmZpZzoKICAgICAgbWF4UG9kczogMTEwCiAgICAgIGNsdXN0ZXJETlM6CiAgICAgIC0gMTAuMTAwLjAuMTAKICAgIGZsYWdzOgogICAgLSAiLS1ub2RlLWxhYmVscz1la3MuYW1hem9uYXdzLmNvbS9zb3VyY2VMYXVuY2hUZW1wbGF0ZVZlcnNpb249MTUsZWtzLmFtYXpvbmF3cy5jb20vbm9kZWdyb3VwLWltYWdlPWFtaS0wODI1ZmY1YTQ0YzM1NGM4MSxla3MuYW1hem9uYXdzLmNvbS9jYXBhY2l0eVR5cGU9T05fREVNQU5ELGVrcy5hbWF6b25hd3MuY29tL25vZGVncm91cD1tb25pdG9yeS1la3Mtbm9kZSxla3MuYW1hem9uYXdzLmNvbS9zb3VyY2VMYXVuY2hUZW1wbGF0ZUlkPWx0LTA3MmQyMGI2NTU4NWE0OWVmIgoKLS0vLy0t"

  iam_instance_profile {
    name = "eks-accbbb09-7b13-ef6f-22bf-51d8a0cc6f52"
  }

  vpc_security_group_ids = [
    var.sg_id_12,
    var.sg_id_4
  ]
  key_name      = "monitory-eks-key"
  image_id      = "ami-0825ff5a44c354c81"
  instance_type = "m7i-flex.large"
}
