resource "aws_lambda_function" "this" {
  for_each = var.functions

  function_name = each.value.function_name
  handler       = each.value.handler
  role          = each.value.role
  runtime       = each.value.runtime
  memory_size   = each.value.memory_size
  timeout       = each.value.timeout
  architectures = each.value.architectures
  s3_bucket     = each.value.s3_bucket
  s3_key        = each.value.s3_key
  s3_object_version = lookup(each.value, "s3_object_version", null)
  description   = lookup(each.value, "description", "")

  dynamic "environment" {
    for_each = lookup(each.value, "environment", []) != [] ? [each.value.environment] : []
    content {
      variables = environment.value.variables
    }
  }

  dynamic "tracing_config" {
    for_each = lookup(each.value, "tracing_config", []) != [] ? [each.value.tracing_config] : []
    content {
      mode = tracing_config.value.mode
    }
  }
}

resource "aws_lambda_permission" "this" {
  for_each = var.permissions

  action        = each.value.action
  function_name = each.value.function_name
  principal     = each.value.principal
  source_arn    = lookup(each.value, "source_arn", null)
}
