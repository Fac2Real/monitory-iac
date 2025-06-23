// DB Subnet Group
module "db_subnet_group" {
  source = "./modules/db_subnet_group"

  neptune_subnet_groups = var.neptune_subnet_groups
  docdb_subnet_groups   = var.docdb_subnet_groups
}

// EC2
module "ec2" {
  source = "./modules/ec2"

  jenkins_free    = var.jenkins_free
  enis            = var.enis
  eni_attachments = var.eni_attachments
}

// ECR
module "ecr" {
  source = "./modules/ecr"

  repositories = var.repositories
}

// EKS
module "eks" {
  source = "./modules/eks"

  cluster_name                   = var.cluster_name
  cluster_role_arn               = var.cluster_role_arn
  cluster_version                = var.cluster_version
  subnet_ids                     = var.subnet_ids

  nodegroup_name                 = var.nodegroup_name
  nodegroup_asg_name             = var.nodegroup_asg_name
  nodegroup_launch_template_name = var.nodegroup_launch_template_name
  nodegroup_security_group_ids   = var.nodegroup_security_group_ids
  nodegroup_key_name             = var.nodegroup_key_name
  nodegroup_instance_type        = var.nodegroup_instance_type
  nodegroup_min_size             = var.nodegroup_min_size
  nodegroup_max_size             = var.nodegroup_max_size
  nodegroup_desired_capacity     = var.nodegroup_desired_capacity
  nodegroup_subnet_ids           = var.nodegroup_subnet_ids
  lifecycle_hook_sns_arn         = var.lifecycle_hook_sns_arn
  sg_id_12                       = var.sg_id_12
  sg_id_4                        = var.sg_id_4
}

// IAM
module "iam" {
  source = "./modules/iam"

  iam_roles                = var.iam_roles
  iam_policies             = var.iam_policies
  iam_role_policies        = var.iam_role_policies
  iam_service_linked_roles = var.iam_service_linked_roles
  iam_instance_profiles    = var.iam_instance_profiles
}

// IoT
module "iot" {
  source = "./modules/iot"

  things                    = var.things
  certificates              = var.certificates
  thing_principal_attachments = var.thing_principal_attachments
  policies                  = var.policies
  policy_attachments        = var.policy_attachments
}

// Kinesis
module "kinesis" {
  source = "./modules/kinesis"

  streams = var.streams
}

// Lambda
module "lambda" {
  source = "./modules/lambda"

  functions   = var.functions
  permissions = var.permissions
}

// Lightsail
module "lightsail" {
  source            = "./modules/lightsail"
  name              = var.name
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = var.key_pair_name
  tags              = var.tags
}

// RDS
module "rds" {
  source = "./modules/rds"

  instances     = var.instances
  subnet_groups = var.subnet_groups
}

// S3
module "s3" {
  source = "./modules/s3"

  buckets        = var.buckets
  bucket_policies = var.bucket_policies
}

// Security Groups
module "sg" {
  source = "./modules/sg"

  security_groups = var.security_groups
}

// SQS
module "sqs" {
  source = "./modules/sqs"

  queues         = var.queues
  queue_policies = var.queue_policies
}

// VPC
module "vpc" {
  source = "./modules/vpc"

  vpcs                     = var.vpcs
  subnets                  = var.subnets
  internet_gateways        = var.internet_gateways
  eips                     = var.eips
  eip_associations         = var.eip_associations
  dhcp_options             = var.dhcp_options
  dhcp_options_associations = var.dhcp_options_associations
  route_tables             = var.route_tables
  routes                   = var.routes
  route_table_associations = var.route_table_associations
}
