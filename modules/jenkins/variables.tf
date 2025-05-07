// modules/jenkins/variables.tf

variable "vpc_id" {
  description = "VPC ID where the endpoint ENI will reside"
  type        = string
}

variable "key_name" {
  description = "Key pair name for EC2 instances"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for Jenkins EC2 instance"
  type        = string
}

variable "controller_ami_name" {
  description = "AMI name for Jenkins controller"
  type        = string
}
