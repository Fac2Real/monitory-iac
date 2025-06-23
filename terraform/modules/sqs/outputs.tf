output "queue_urls" {
  value = { for k, v in aws_sqs_queue.this : k => v.id }
}

output "queue_names" {
  value = { for k, v in aws_sqs_queue.this : k => v.name }
}
