// root/variables.tf

locals {
  vpc_id                   = length(data.aws_vpcs.monitory.ids) > 0 ? data.aws_vpcs.monitory.ids[0] : module.vpc[0].vpc_id
  vpc_cidr_block           = length(data.aws_vpc.monitory_detail) > 0 ? data.aws_vpc.monitory_detail[0].cidr_block : module.vpc[0].vpc_cidr_block
  private_subnet_id        = length(data.aws_subnets.private.ids) > 0 ? data.aws_subnets.private.ids[0] : module.vpc[0].private_subnet_id
  unused_subnet_id         = length(data.aws_subnets.unused.ids) > 0 ? data.aws_subnets.unused.ids[0] : module.vpc[0].unused_subnet_id
  public_subnet_id         = length(data.aws_subnets.public.ids) > 0 ? data.aws_subnets.public.ids[0] : module.vpc[0].public_subnet_id
  endpoint_sg_id           = length(data.aws_security_groups.endpoint_exist.ids) > 0 ? data.aws_security_groups.endpoint_exist.ids[0] : module.endpoint_sg[0].endpoint_sg_id
  private_link_id          = length(data.aws_vpc_endpoint.existing) > 0 ? data.aws_vpc_endpoint.existing[0].id : module.private_link[0].iot_data_endpoint_id
  jenkins_controller_id    = length(data.aws_instances.jenkins_controller.ids) > 0 ? data.aws_instances.jenkins_controller.ids[0] : module.jenkins[0].jenkins_controller_id
  jenkins_controller_sg_id = length(data.aws_instances.jenkins_controller.ids) > 0 ? tolist(data.aws_instance.jenkins_controller_details[0].vpc_security_group_ids)[0] : module.jenkins[0].jenkins_controller_sg_id
}

variable "db_username" {
  description = "RDS DB username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS DB password"
  type        = string
  sensitive   = true
}

