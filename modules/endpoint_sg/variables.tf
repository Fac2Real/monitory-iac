// modules/endpoint_sg/variables.tf

variable "vpc_id" {
  description = "VPC ID where the endpoint ENI will reside"
  type        = string
}
variable "vpc_cidr_block" {
  description = "CIDR block of the VPC for limiting ingress"
  type        = string
}
variable "endpoint_sg_name" {
  description = "Name for the PrivateLink endpoint SG"
  type        = string
}
