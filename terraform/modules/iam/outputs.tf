output "role_arns" {
  value = { for k, v in aws_iam_role.this : k => v.arn }
}

output "policy_arns" {
  value = { for k, v in aws_iam_policy.this : k => v.arn }
}

output "instance_profile_names" {
  value = { for k, v in aws_iam_instance_profile.this : k => v.name }
}
