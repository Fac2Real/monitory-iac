output "repository_urls" {
  description = "생성된 ECR 리포지토리들의 URL 맵(name → url)"
  value       = { for n, repo in aws_ecr_repository.this : n => repo.repository_url }
}
