# IAM Roles
resource "aws_iam_role" "this" {
  for_each             = var.iam_roles
  name                 = each.value.name
  path                 = lookup(each.value, "path", "/")
  assume_role_policy   = each.value.assume_role_policy
  max_session_duration = lookup(each.value, "max_session_duration", 3600)
  tags                 = lookup(each.value, "tags", {})
}

# IAM Policies
resource "aws_iam_policy" "this" {
  for_each = var.iam_policies
  name     = each.value.name
  path     = lookup(each.value, "path", "/")
  policy   = each.value.policy
}

# IAM Role Policies (inline)
resource "aws_iam_role_policy" "this" {
  for_each = var.iam_role_policies
  name     = each.value.name
  role     = each.value.role
  policy   = each.value.policy
}

# IAM Service Linked Roles
resource "aws_iam_service_linked_role" "this" {
  for_each        = var.iam_service_linked_roles
  aws_service_name = each.value.aws_service_name
  description      = lookup(each.value, "description", null)
}

# IAM Instance Profiles
resource "aws_iam_instance_profile" "this" {
  for_each = var.iam_instance_profiles
  name     = each.value.name
  path     = lookup(each.value, "path", "/")
  role     = each.value.role
}
