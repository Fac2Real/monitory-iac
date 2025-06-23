variable "cluster_name" {
  type        = string
  description = "EKS 클러스터 이름"
}

variable "cluster_role_arn" {
  type        = string
  description = "EKS 클러스터에 할당할 IAM Role ARN"
}

variable "cluster_version" {
  type        = string
  description = "EKS 클러스터 버전"
  default     = "1.32"
}

variable "subnet_ids" {
  type        = list(string)
  description = "EKS 클러스터 및 노드그룹에 사용할 서브넷 ID 리스트"
}

variable "nodegroup_name" {
  type        = string
  description = "노드그룹 이름"
}

variable "nodegroup_asg_name" {
  type        = string
  description = "노드그룹 오토스케일링 그룹 이름"
}

variable "nodegroup_launch_template_name" {
  type        = string
  description = "노드그룹에 사용할 Launch Template 이름"
}

variable "nodegroup_security_group_ids" {
  type        = list(string)
  description = "노드그룹 인스턴스에 적용할 SG 리스트"
}

variable "nodegroup_key_name" {
  type        = string
  description = "노드그룹 EC2 인스턴스 SSH 키 이름"
}

variable "nodegroup_instance_type" {
  type        = string
  description = "노드그룹 EC2 인스턴스 타입"
}

variable "nodegroup_min_size" {
  type        = number
  description = "노드그룹 최소 인스턴스 수"
}

variable "nodegroup_max_size" {
  type        = number
  description = "노드그룹 최대 인스턴스 수"
}

variable "nodegroup_desired_capacity" {
  type        = number
  description = "노드그룹 초기 인스턴스 수"
}

variable "nodegroup_subnet_ids" {
  type        = list(string)
  description = "노드그룹 인스턴스가 배치될 서브넷 리스트"
}

variable "lifecycle_hook_sns_arn" {
  type        = string
  description = "ASG 라이프사이클 훅 SNS ARN"
}

variable "sg_id_12" {
  description = "EC2SecurityGroup12의 ID"
  type        = string
}

variable "sg_id_4" {
  description = "EC2SecurityGroup4의 ID"
  type        = string
}
