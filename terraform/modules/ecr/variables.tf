variable "repositories" {
  description = "ECR 리포지토리 목록(map)"
  type = map(object({
    name = string
  }))
}
