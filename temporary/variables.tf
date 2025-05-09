// root/variables.tf

locals {
  vpc_id                   = data.aws_vpcs.monitory.ids[0]
  vpc_cidr_block           = data.aws_vpc.monitory_detail[0].cidr_block
  private_subnet_id        = data.aws_subnets.private.ids[0]
  unused_subnet_id         = data.aws_subnets.unused.ids[0]
  public_subnet_id         = data.aws_subnets.public.ids[0]
  endpoint_sg_id           = data.aws_security_groups.endpoint_exist.ids[0]
  jenkins_controller_id    = data.aws_instances.jenkins_controller.ids[0]
  jenkins_controller_sg_id = tolist(data.aws_instance.jenkins_controller_details[0].vpc_security_group_ids)[0]
}
