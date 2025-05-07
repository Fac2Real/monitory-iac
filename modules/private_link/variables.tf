// modules/private_link/variables.tf
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs for Interface Endpoint ENIs"
  type        = list(string)
}
variable "security_group_ids" {
  description = "SG IDs to attach to Interface Endpoint ENIs"
  type        = list(string)
}
variable "region" {
  description = "AWS region for service endpoints"
  type        = string
}

variable "privatelink_name" {
  description = "Logical name for the PrivateLink endpoint (used as the Name tag)"
  type        = string
}
