variable "queues" {
  description = "SQS 큐 정의 map"
  type = map(object({
    name                      = string
    delay_seconds             = number
    max_message_size          = number
    message_retention_seconds = number
    receive_wait_time_seconds = number
    visibility_timeout_seconds = number
  }))
}

variable "queue_policies" {
  description = "SQS 큐 정책 정의 map"
  type = map(object({
    queue_ref = string
    policy    = string
  }))
  default = {}
}
