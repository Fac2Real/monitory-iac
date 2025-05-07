// modules/private_link/main.tf

resource "aws_vpc_endpoint" "iot_data" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.iot.data"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = false
}