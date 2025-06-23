resource "aws_s3_bucket" "this" {
  for_each = var.buckets
  bucket   = each.value.bucket
}

resource "aws_s3_bucket_policy" "this" {
  for_each = var.bucket_policies

  bucket = aws_s3_bucket.this[each.value.bucket_ref].id
  policy = each.value.policy
}
