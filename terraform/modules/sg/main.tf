resource "aws_security_group" "this" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
  tags        = merge({ Name = each.value.name }, lookup(each.value, "tags", {}))

  dynamic "ingress" {
    for_each = lookup(each.value, "ingress", [])
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = lookup(ingress.value, "cidr_blocks", null)
      security_groups = lookup(ingress.value, "security_groups", null)
      description = lookup(ingress.value, "description", null)
    }
  }

  dynamic "egress" {
    for_each = lookup(each.value, "egress", [])
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = lookup(egress.value, "cidr_blocks", null)
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", null)
      description = lookup(egress.value, "description", null)
    }
  }
}
