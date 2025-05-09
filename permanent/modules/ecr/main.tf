// modules/ecr/main.tf

resource "aws_ecr_repository" "this" {
  for_each = toset(var.repo_names)

  name                 = each.key
  image_tag_mutability = "MUTABLE"
  tags                 = merge(var.tags, { Name = each.key })
}
