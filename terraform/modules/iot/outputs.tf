output "thing_names" {
  value = [for t in aws_iot_thing.this : t.name]
}

output "certificate_arns" {
  value = [for c in aws_iot_certificate.this : c.arn]
}

output "policy_names" {
  value = [for p in aws_iot_policy.this : p.name]
}
