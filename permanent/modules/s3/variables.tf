// modules/s3/variables.tf

variable "bucket_name" {
  description = "생성할 S3 버킷 이름"
  type        = string
}

variable "versioning" {
  description = "버전 관리를 활성화할지 여부"
  type        = bool
}

variable "tags" {
  description = "버킷에 붙일 태그들"
  type        = map(string)
}
