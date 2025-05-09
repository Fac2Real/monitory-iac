// root/main.tf

module "private_link" {
  source = "./modules/private_link"

  vpc_id             = local.vpc_id
  subnet_ids         = [local.private_subnet_id]
  security_group_ids = [local.endpoint_sg_id]
  region             = "ap-northeast-2"
  privatelink_name   = "monitory-privatelink"
}
