// root/main.tf

data "aws_vpcs" "monitory" {
  filter {
    name   = "tag:Name"
    values = ["monitory-vpc"]
  }
}

module "vpc" {
  source = "./modules/vpc"
  count  = length(data.aws_vpcs.monitory.ids) > 0 ? 0 : 1

}

locals {
  vpc_id = length(data.aws_vpcs.monitory.ids) > 0 ? data.aws_vpcs.monitory.ids[0] : module.vpc[0].vpc_id
}

module "endpoint_sg" {
  source = "./modules/endpoint_sg"
  count  = length(data.aws_vpcs.monitory.ids) > 0 ? 0 : 1

  vpc_id            = local.vpc_id
  vpc_cidr_block    = module.vpc[0].vpc_cidr_block
  endpoint_sg_name  = "monitory-endpoint-sg"

  depends_on = [module.vpc]
}

module "private_link" {
  source = "./modules/private_link"
  count  = length(data.aws_vpcs.monitory.ids) > 0 ? 0 : 1

  vpc_id             = module.vpc[0].vpc_id
  region             = "ap-northeast-2"
  subnet_ids         = [module.vpc[0].private_subnet_id]
  security_group_ids = [module.endpoint_sg[0].endpoint_sg_id]

  depends_on = [module.endpoint_sg]
}