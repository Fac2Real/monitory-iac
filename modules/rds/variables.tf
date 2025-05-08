variable "vpc_id" {
  description = "VPC ID where the RDS instance will reside"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "allowed_sg_ids" {
  description = "List of security group IDs to allow access to the RDS instance"
  type        = list(string)
}

variable "db_identifier" {
  description = "RDS DB instance identifier"
  type        = string
}

variable "db_name" {
  description = "RDS DB name"
  type        = string
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
