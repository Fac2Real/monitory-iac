variable "name" {
  description = "Lightsail 인스턴스 이름"
  type        = string
}

variable "availability_zone" {
  description = "Lightsail 인스턴스 AZ"
  type        = string
}

variable "blueprint_id" {
  description = "Lightsail OS/Blueprint ID"
  type        = string
}

variable "bundle_id" {
  description = "Lightsail 플랜 ID"
  type        = string
}

variable "key_pair_name" {
  description = "SSH 키 페어 이름"
  type        = string
}

variable "tags" {
  description = "태그"
  type        = map(string)
  default     = {}
}
