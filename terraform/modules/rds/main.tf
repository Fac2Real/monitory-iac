resource "aws_db_instance" "this" {
  for_each                     = var.instances
  identifier                   = each.value.identifier
  allocated_storage            = each.value.allocated_storage
  instance_class               = each.value.instance_class
  engine                       = each.value.engine
  username                     = each.value.username
  password                     = each.value.password
  db_name                      = each.value.name
  backup_window                = each.value.backup_window
  backup_retention_period      = each.value.backup_retention_period
  availability_zone            = each.value.availability_zone
  maintenance_window           = each.value.maintenance_window
  multi_az                     = each.value.multi_az
  engine_version               = each.value.engine_version
  auto_minor_version_upgrade   = each.value.auto_minor_version_upgrade
  license_model                = each.value.license_model
  publicly_accessible          = each.value.publicly_accessible
  storage_type                 = each.value.storage_type
  port                         = each.value.port
  storage_encrypted            = each.value.storage_encrypted
  copy_tags_to_snapshot        = each.value.copy_tags_to_snapshot
  monitoring_interval          = each.value.monitoring_interval
  iam_database_authentication_enabled = each.value.iam_database_authentication_enabled
  deletion_protection          = each.value.deletion_protection
  db_subnet_group_name         = each.value.db_subnet_group_name
  vpc_security_group_ids       = each.value.vpc_security_group_ids
  max_allocated_storage        = each.value.max_allocated_storage
}

resource "aws_db_subnet_group" "this" {
  for_each    = var.subnet_groups
  name        = each.value.name
  description = each.value.description
  subnet_ids  = each.value.subnet_ids
}
