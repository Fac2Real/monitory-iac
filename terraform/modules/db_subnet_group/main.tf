resource "aws_neptune_subnet_group" "this" {
  for_each    = var.neptune_subnet_groups
  name        = each.value.name
  description = each.value.description
  subnet_ids  = each.value.subnet_ids
}

resource "aws_docdb_subnet_group" "this" {
  for_each    = var.docdb_subnet_groups
  name        = each.value.name
  description = each.value.description
  subnet_ids  = each.value.subnet_ids
}
