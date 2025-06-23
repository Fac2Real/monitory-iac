resource "aws_kinesis_stream" "this" {
  for_each       = var.streams
  name           = each.value.name
  shard_count    = each.value.shard_count
  retention_period = lookup(each.value, "retention_period", 24)
  encryption_type  = lookup(each.value, "encryption_type", "NONE")
}
