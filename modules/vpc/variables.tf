// modules/vpc/variables.tf

variable "aws_region" {
  description = "AWS 리전을 선택합니다."
  type        = string
  default     = "ap-northeast-2"
}

variable "vpc_cidr" {
  description = "VPC에 사용할 CIDR 블록입니다."
  type        = string
  default     = "172.31.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public 서브넷에 사용할 CIDR 블록 목록입니다. (가용 영역 수만큼 필요)"
  type        = string
  default     = "172.31.32.0/20"
}

variable "private_subnet_cidrs" {
  description = "Private 서브넷에 사용할 CIDR 블록 목록입니다. (가용 영역 수만큼 필요)"
  type        = string
  default     = "172.31.0.0/20"
}

variable "availability_zones" {
  description = "사용할 가용 영역(AZ) 목록입니다."
  type        = string
  default     = "ap-northeast-2a"
}
