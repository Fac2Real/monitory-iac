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
