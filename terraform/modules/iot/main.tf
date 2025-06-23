resource "aws_iot_thing" "this" {
  for_each   = var.things
  name       = each.value.name
  attributes = lookup(each.value, "attributes", {})
}

resource "aws_iot_certificate" "this" {
  for_each = var.certificates
  active   = each.value.active
  csr      = each.value.csr
}

resource "aws_iot_thing_principal_attachment" "this" {
  for_each  = var.thing_principal_attachments
  thing     = each.value.thing
  principal = each.value.principal
}

resource "aws_iot_policy" "this" {
  for_each = var.policies
  name     = each.value.name
  policy   = each.value.policy
}

resource "aws_iot_policy_attachment" "this" {
  for_each = var.policy_attachments
  policy   = each.value.policy
  target   = each.value.target
}