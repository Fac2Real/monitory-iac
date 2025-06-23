variable "instances" {
  description = "RDS 인스턴스 정의 map"
  type = map(object({
    identifier                        = string
    allocated_storage                 = number
    instance_class                    = string
    engine                            = string
    username                          = string
    password                          = string
    name                              = string
    backup_window                     = string
    backup_retention_period           = number
    availability_zone                 = string
    maintenance_window                = string
    multi_az                          = bool
    engine_version                    = string
    auto_minor_version_upgrade        = bool
    license_model                     = string
    publicly_accessible               = bool
    storage_type                      = string
    port                              = number
    storage_encrypted                 = bool
    copy_tags_to_snapshot             = bool
    monitoring_interval               = number
    iam_database_authentication_enabled = bool
    deletion_protection               = bool
    db_subnet_group_name              = string
    vpc_security_group_ids            = list(string)
    max_allocated_storage             = number
  }))
}

variable "subnet_groups" {
  description = "DB Subnet Group 정의 map"
  type = map(object({
    name        = string
    description = string
    subnet_ids  = list(string)
  }))
}
