output "repository_urls" {
  description = "생성된 ECR 리포지토리 URL 목록"
  value = { for k, v in aws_ecr_repository.this : k => v.repository_url }
}

output "repository_names" {
  description = "생성된 ECR 리포지토리 이름 목록"
  value = { for k, v in aws_ecr_repository.this : k => v.name }
}
