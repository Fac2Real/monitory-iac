variable "buckets" {
  description = "S3 버킷 정의 map"
  type = map(object({
    bucket = string
  }))
}

variable "bucket_policies" {
  description = "S3 버킷 정책 정의 map"
  type = map(object({
    bucket_ref = string
    policy     = string
  }))
  default = {}
}
