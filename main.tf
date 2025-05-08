// root/main.tf

module "vpc" {
  source = "./modules/vpc"
  count  = length(data.aws_vpcs.monitory.ids) > 0 ? 0 : 1

  aws_region           = "ap-northeast-2"
  vpc_cidr             = "172.31.0.0/16"
  public_subnet_cidrs  = "172.31.32.0/20"
  private_subnet_cidrs = ["172.31.0.0/20", "172.31.16.0/20"]
  availability_zones   = ["ap-northeast-2a", "ap-northeast-2c"]
}

module "endpoint_sg" {
  source = "./modules/endpoint_sg"
  count  = length(data.aws_security_groups.endpoint_exist.ids) > 0 ? 0 : 1

  vpc_id           = local.vpc_id
  vpc_cidr_block   = local.vpc_cidr_block
  endpoint_sg_name = "monitory-endpoint-sg"

  depends_on = [module.vpc]
}

module "private_link" {
  source = "./modules/private_link"
  count  = length(data.aws_security_groups.endpoint_exist.ids) > 0 ? 0 : 1

  vpc_id             = local.vpc_id
  subnet_ids         = [local.private_subnet_id]
  security_group_ids = [local.endpoint_sg_id]
  region             = "ap-northeast-2"
  privatelink_name   = "monitory-privatelink"

  depends_on = [module.endpoint_sg]
}

module "jenkins" {
  source = "./modules/jenkins"
  count  = length(data.aws_instances.jenkins_controller_exist.ids) > 0 ? 0 : 1

  vpc_id              = local.vpc_id
  public_subnet_id    = local.public_subnet_id
  key_name            = "monitory-jenkins"
  controller_ami_name = "jenkins-controller-ami-*"

  depends_on = [module.vpc]
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "monitory-bucket"
  versioning  = false
  tags        = {}
}