// root/data.tf

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

# Retrieve unused subnet(s) by tag
data "aws_subnets" "unused" {
  filter {
    name   = "tag:Name"
    values = ["unused-subnet"]
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

# Check for existing Jenkins controller instances
data "aws_instances" "jenkins_controller" {
  filter {
    name   = "tag:Name"
    values = ["jenkins-controller"]
  }
  filter {
    name   = "instance-state-name"
    values = ["running", "stopped"]
  }
}

data "aws_instance" "jenkins_controller_details" {
  count       = length(data.aws_instances.jenkins_controller.ids) > 0 ? 1 : 0
  instance_id = data.aws_instances.jenkins_controller.ids[0]
}
