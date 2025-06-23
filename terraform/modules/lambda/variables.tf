variable "functions" {
  description = "Lambda 함수 정의"
  type = map(object({
    function_name    = string
    handler          = string
    role             = string
    runtime          = string
    memory_size      = number
    timeout          = number
    architectures    = list(string)
    s3_bucket        = string
    s3_key           = string
    s3_object_version = optional(string)
    description      = optional(string)
    environment = optional(object({
      variables = map(string)
    }))
    tracing_config = optional(object({
      mode = string
    }))
  }))
}

variable "permissions" {
  description = "Lambda 권한 정의"
  type = map(object({
    action        = string
    function_name = string
    principal     = string
    source_arn    = optional(string)
  }))
}
