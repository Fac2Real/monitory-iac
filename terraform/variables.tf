// DB Subnet Group
variable "neptune_subnet_groups" {
  description = "Neptune DB subnet groups"
  type = map(object({
    name        = string
    description = string
    subnet_ids  = list(string)
  }))
}

variable "docdb_subnet_groups" {
  description = "DocumentDB subnet groups"
  type = map(object({
    name        = string
    description = string
    subnet_ids  = list(string)
  }))
}

// EC2
variable "jenkins_free" {
  description = "Jenkins EC2 instance configuration"
  type = object({
    ami                    = string
    instance_type          = string
    key_name               = string
    availability_zone      = string
    tenancy                = string
    subnet_id              = string
    ebs_optimized          = bool
    vpc_security_group_ids = list(string)
    source_dest_check      = bool
    root_block_device = object({
      volume_size           = number
      volume_type           = string
      delete_on_termination = bool
    })
    iam_instance_profile = string
    tags                = map(string)
  })
}

variable "enis" {
  description = "EC2 network interfaces"
  type = map(object({
    description       = string
    private_ips       = list(string)
    subnet_id         = string
    source_dest_check = bool
    security_groups   = list(string)
  }))
}

variable "eni_attachments" {
  description = "EC2 network interface attachments"
  type = map(object({
    network_interface_id = string
    device_index         = number
    instance_id          = string
  }))
}

// ECR
variable "repositories" {
  description = "ECR repositories"
  type = map(object({
    name = string
  }))
}

// EKS
variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}
variable "cluster_role_arn" {
  type        = string
  description = "EKS cluster role ARN"
}
variable "cluster_version" {
  type        = string
  description = "EKS cluster version"
}
variable "subnet_ids" {
  type        = list(string)
  description = "EKS subnet IDs"
}
variable "nodegroup_name" {
  type        = string
  description = "EKS nodegroup name"
}
variable "nodegroup_asg_name" {
  type        = string
  description = "EKS nodegroup ASG name"
}
variable "nodegroup_launch_template_name" {
  type        = string
  description = "EKS launch template name"
}
variable "nodegroup_security_group_ids" {
  type        = list(string)
  description = "EKS nodegroup security group IDs"
}
variable "nodegroup_key_name" {
  type        = string
  description = "EKS nodegroup key name"
}
variable "nodegroup_instance_type" {
  type        = string
  description = "EKS nodegroup instance type"
}
variable "nodegroup_min_size" {
  type        = number
  description = "EKS nodegroup min size"
}
variable "nodegroup_max_size" {
  type        = number
  description = "EKS nodegroup max size"
}
variable "nodegroup_desired_capacity" {
  type        = number
  description = "EKS nodegroup desired capacity"
}
variable "nodegroup_subnet_ids" {
  type        = list(string)
  description = "EKS nodegroup subnet IDs"
}
variable "lifecycle_hook_sns_arn" {
  type        = string
  description = "Lifecycle hook SNS ARN"
}
variable "sg_id_12" {
  type        = string
  description = "Security group ID 12"
}
variable "sg_id_4" {
  type        = string
  description = "Security group ID 4"
}

// IAM
variable "iam_roles" {
  description = "IAM roles"
  type = map(object({
    name                 = string
    path                 = string
    assume_role_policy   = string
    max_session_duration = number
  }))
}
variable "iam_policies" {
  description = "IAM policies"
  type = map(object({
    name   = string
    path   = string
    policy = string
  }))
}
variable "iam_role_policies" {
  description = "IAM inline role policies"
  type = map(object({
    name   = string
    role   = string
    policy = string
  }))
}
variable "iam_service_linked_roles" {
  description = "IAM service linked roles"
  type = map(object({
    aws_service_name = string
    description      = optional(string)
  }))
}
variable "iam_instance_profiles" {
  description = "IAM instance profiles"
  type = map(object({
    name  = string
    roles = list(string)
    path  = string
  }))
}

// IoT
variable "things" {
  description = "IoT things"
  type = map(object({
    name       = string
    attributes = map(string)
  }))
}
variable "certificates" {
  description = "IoT certificates"
  type = map(object({
    active = bool
    csr    = string
  }))
}
variable "thing_principal_attachments" {
  description = "IoT thing-principal attachments"
  type = map(object({
    thing     = string
    principal = string
  }))
}
variable "policies" {
  description = "IoT policies"
  type = map(object({
    name   = string
    policy = string
  }))
}
variable "policy_attachments" {
  description = "IoT policy attachments"
  type = map(object({
    policy = string
    target = string
  }))
}

// Kinesis
variable "streams" {
  description = "Kinesis streams"
  type = map(object({
    name            = string
    shard_count     = number
    retention_period = number
    encryption_type = string
  }))
}

// Lambda
variable "functions" {
  description = "Lambda functions"
  type = map(object({
    function_name     = string
    handler           = string
    role              = string
    runtime           = string
    memory_size       = number
    timeout           = number
    architectures     = list(string)
    s3_bucket         = string
    s3_key            = string
    s3_object_version = string
    description       = string
    environment       = optional(object({
      variables = map(string)
    }))
    tracing_config    = optional(object({
      mode = string
    }))
  }))
}
variable "permissions" {
  description = "Lambda permissions"
  type = map(object({
    action        = string
    function_name = string
    principal     = string
    source_arn    = string
  }))
}

// Lightsail
variable "name" {
  description = "Lightsail instance name"
  type        = string
}
variable "availability_zone" {
  description = "Lightsail AZ"
  type        = string
}
variable "blueprint_id" {
  description = "Lightsail blueprint"
  type        = string
}
variable "bundle_id" {
  description = "Lightsail bundle"
  type        = string
}
variable "key_pair_name" {
  description = "Lightsail key pair"
  type        = string
}
variable "tags" {
  description = "Lightsail tags"
  type        = map(string)
}

// RDS
variable "instances" {
  description = "RDS instances"
  type = map(object({
    identifier                          = string
    allocated_storage                   = number
    instance_class                      = string
    engine                              = string
    username                            = string
    password                            = string
    name                                = string
    backup_window                       = string
    backup_retention_period             = number
    availability_zone                   = string
    maintenance_window                  = string
    multi_az                            = bool
    engine_version                      = string
    auto_minor_version_upgrade          = bool
    license_model                       = string
    publicly_accessible                 = bool
    storage_type                        = string
    port                                = number
    storage_encrypted                   = bool
    copy_tags_to_snapshot               = bool
    monitoring_interval                 = number
    iam_database_authentication_enabled = bool
    deletion_protection                 = bool
    db_subnet_group_name                = string
    vpc_security_group_ids              = list(string)
    max_allocated_storage               = number
  }))
}
variable "subnet_groups" {
  description = "RDS subnet groups"
  type = map(object({
    name        = string
    description = string
    subnet_ids  = list(string)
  }))
}

// S3
variable "buckets" {
  description = "S3 buckets"
  type = map(object({
    bucket = string
  }))
}
variable "bucket_policies" {
  description = "S3 bucket policies"
  type = map(object({
    bucket_ref = string
    policy     = string
  }))
}

// Security Groups
variable "security_groups" {
  description = "Security groups"
  type = map(object({
    name        = string
    description = string
    vpc_id      = string
    tags        = map(string)
    ingress     = list(object({
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
      ipv6_cidr_blocks = optional(list(string))
      description     = optional(string)
    }))
    egress      = list(object({
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string))
      ipv6_cidr_blocks = optional(list(string))
      description     = optional(string)
    }))
  }))
}

// SQS
variable "queues" {
  description = "SQS queues"
  type = map(object({
    name                       = string
    delay_seconds              = number
    max_message_size           = number
    message_retention_seconds  = number
    receive_wait_time_seconds  = number
    visibility_timeout_seconds = number
  }))
}
variable "queue_policies" {
  description = "SQS queue policies"
  type = map(object({
    queue_ref = string
    policy    = string
  }))
}

// VPC
variable "vpcs" {
  description = "VPCs"
  type = map(object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
    instance_tenancy     = string
    tags                 = map(string)
  }))
}
variable "subnets" {
  description = "Subnets"
  type = map(object({
    availability_zone       = string
    cidr_block              = string
    vpc_ref                 = string
    map_public_ip_on_launch = bool
  }))
}
variable "internet_gateways" {
  description = "Internet gateways"
  type = map(object({
    vpc_ref = string
    tags    = map(string)
  }))
}
variable "eips" {
  description = "Elastic IPs"
  type = map(object({
    instance = string
  }))
}
variable "eip_associations" {
  description = "EIP associations"
  type = map(object({
    allocation_id        = string
    instance_id          = string
    network_interface_id = string
    private_ip_address   = string
  }))
}
variable "dhcp_options" {
  description = "DHCP options"
  type = map(object({
    domain_name = string
    tags        = map(string)
  }))
}
variable "dhcp_options_associations" {
  description = "DHCP options associations"
  type = map(object({
    dhcp_options_id = string
    vpc_ref         = string
  }))
}
variable "route_tables" {
  description = "Route tables"
  type = map(object({
    vpc_ref = string
    tags    = map(string)
  }))
}
variable "routes" {
  description = "Routes"
  type = map(object({
    destination_cidr_block = string
    gateway_id             = string
    route_table_id         = string
  }))
}
variable "route_table_associations" {
  description = "Route table associations"
  type = map(object({
    route_table_id = string
    subnet_id      = string
  }))
}
