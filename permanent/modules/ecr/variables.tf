// modules/ecr/variables.tf

variable "repo_names" {
  description = "생성할 ECR 리포지토리 이름 리스트"
  type        = list(string)
}

variable "tags" {
  description = "리포지토리에 적용할 태그"
  type        = map(string)
}
