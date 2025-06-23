variable "streams" {
  description = "Kinesis 스트림 정의 map"
  type = map(object({
    name            = string
    shard_count     = number
    retention_period = optional(number)
    encryption_type  = optional(string)
  }))
}
