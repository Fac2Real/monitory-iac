data "aws_db_subnet_group" "neptune" {
  for_each = var.neptune_subnet_groups
  name     = each.value.name
}

data "aws_db_subnet_group" "docdb" {
  for_each = var.docdb_subnet_groups
  name     = each.value.name
}

data "aws_ami" "jenkins_free" {
  most_recent = true
  filter {
    name   = "image-id"
    values = [var.ec2_instances["jenkins_free"].ami]
  }
}

data "aws_key_pair" "jenkins_free" {
  key_name = var.ec2_instances["jenkins_free"].key_name
}

data "aws_iam_instance_profile" "jenkins_free" {
  name = var.ec2_instances["jenkins_free"].iam_instance_profile
}

data "aws_network_interface" "eni" {
  for_each = var.enis
  filter {
    name   = "private-ip-address"
    values = [each.value.private_ips[0]]
  }
}

data "aws_network_interface" "attachment" {
  for_each = var.eni_attachments
  id       = each.value.network_interface_id
}

data "aws_vpc" "jenkins" {
  filter {
    name   = "tag:Name"
    values = [var.vpcs["jenkins"].tags["Name"]]
  }
}

data "aws_vpc" "monitory" {
  filter {
    name   = "tag:Name"
    values = [var.vpcs["monitory"].tags["Name"]]
  }
}

data "aws_subnet_ids" "jenkins" {
  vpc_id = data.aws_vpc.jenkins.id
}

data "aws_subnet_ids" "monitory" {
  vpc_id = data.aws_vpc.monitory.id
}

data "aws_internet_gateway" "jenkins" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.jenkins.id]
  }
}

data "aws_internet_gateway" "monitory" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.monitory.id]
  }
}

data "aws_eip" "eip" {
  for_each = var.eips
  filter {
    name   = "instance-id"
    values = [each.value.instance]
  }
}

data "aws_dhcp_options" "dhcp" {
  for_each = var.dhcp_options_associations
  id       = each.value.dhcp_options_id
}

data "aws_route_table" "route_table" {
  for_each = var.route_tables
  filter {
    name   = "tag:Name"
    values = [each.value.tags["Name"]]
  }
}

data "aws_security_group" "sg" {
  for_each = var.security_groups
  name     = each.value.name
  vpc_id   = data.aws_vpc[each.value.vpc_ref].id
}

data "aws_s3_bucket" "bucket" {
  for_each = var.buckets
  bucket   = each.value.bucket
}

data "aws_sqs_queue" "queue" {
  for_each = var.queues
  name     = each.value.name
}

data "aws_db_subnet_group" "rds" {
  for_each = var.subnet_groups
  name     = each.value.name
}
