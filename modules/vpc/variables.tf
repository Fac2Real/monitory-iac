// modules/vpc/variables.tf

variable "aws_region" {
  description = "AWS 리전을 선택합니다."
  type        = string
}

variable "vpc_cidr" {
  description = "VPC에 사용할 CIDR 블록입니다."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public 서브넷에 사용할 CIDR 블록 목록입니다. (가용 영역 수만큼 필요)"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "Private 서브넷에 사용할 CIDR 블록 목록입니다. (가용 영역 수만큼 필요)"
  type        = string
}

variable "availability_zones" {
  description = "사용할 가용 영역(AZ) 목록입니다."
  type        = string
}
