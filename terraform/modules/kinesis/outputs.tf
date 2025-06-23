output "stream_arns" {
  description = "생성된 Kinesis 스트림의 ARN 목록"
  value = { for k, v in aws_kinesis_stream.this : k => v.arn }
}

output "stream_names" {
  description = "생성된 Kinesis 스트림 이름 목록"
  value = { for k, v in aws_kinesis_stream.this : k => v.name }
}
