data "aws_vpcs" "monitory" {
  filter {
    name   = "tag:Name"
    values = ["monitory-vpc"]
  }
}

# Retrieve details of the existing VPC (if one already exists)
data "aws_vpc" "monitory_detail" {
  count = length(data.aws_vpcs.monitory.ids) > 0 ? 1 : 0
  id    = element(data.aws_vpcs.monitory.ids, 0)
}

# Retrieve private subnet(s) by tag
data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet"]
  }
}

# Retrieve public subnet(s) by tag
data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet"]
  }
}

# Check if an SG named "monitory-endpoint-sg" already exists
data "aws_security_groups" "endpoint_exist" {
  filter {
    name   = "tag:Name"
    values = ["monitory-endpoint-sg"]
  }
}

data "aws_vpc_endpoint" "existing" {
  count = length(data.aws_vpcs.monitory.ids) > 0 ? 1 : 0
  filter {
    name   = "tag:Name"
    values = ["monitory-privatelink"]
  }
}

# Check for existing Jenkins controller instances
data "aws_instances" "jenkins_controller_exist" {
  filter {
    name   = "tag:Name"
    values = ["jenkins-controller"]
  }
  filter {
    name   = "instance-state-name"
    values = ["running", "stopped"]
  }
}

locals {
  vpc_id                = length(data.aws_vpcs.monitory.ids) > 0 ? data.aws_vpcs.monitory.ids[0] : module.vpc[0].vpc_id
  vpc_cidr_block        = length(data.aws_vpc.monitory_detail) > 0 ? data.aws_vpc.monitory_detail[0].cidr_block : module.vpc[0].vpc_cidr_block
  private_subnet_id     = length(data.aws_subnets.private.ids) > 0 ? data.aws_subnets.private.ids[0] : module.vpc[0].private_subnet_id
  public_subnet_id      = length(data.aws_subnets.public.ids) > 0 ? data.aws_subnets.public.ids[0] : module.vpc[0].public_subnet_id
  endpoint_sg_id        = length(data.aws_security_groups.endpoint_exist.ids) > 0 ? data.aws_security_groups.endpoint_exist.ids[0] : module.endpoint_sg[0].endpoint_sg_id
  private_link_id       = length(data.aws_vpc_endpoint.existing) > 0 ? data.aws_vpc_endpoint.existing[0].id : module.private_link[0].iot_data_endpoint_id
  jenkins_controller_id = length(data.aws_instances.jenkins_controller_exist.ids) > 0 ? data.aws_instances.jenkins_controller_exist.ids[0] : module.jenkins[0].jenkins_controller_id
}
