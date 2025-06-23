resource "aws_sqs_queue" "this" {
  for_each = var.queues

  name                        = each.value.name
  delay_seconds               = each.value.delay_seconds
  max_message_size            = each.value.max_message_size
  message_retention_seconds   = each.value.message_retention_seconds
  receive_wait_time_seconds   = each.value.receive_wait_time_seconds
  visibility_timeout_seconds  = each.value.visibility_timeout_seconds
}

resource "aws_sqs_queue_policy" "this" {
  for_each = var.queue_policies

  queue_url = aws_sqs_queue.this[each.value.queue_ref].id
  policy    = each.value.policy
}






resource "aws_sqs_queue" "SQSQueue" {
    delay_seconds = "0"
    max_message_size = "262144"
    message_retention_seconds = "345600"
    receive_wait_time_seconds = "0"
    visibility_timeout_seconds = "30"
    name = "S3NewJsonEventAlert"
}

resource "aws_sqs_queue" "SQSQueue2" {
    delay_seconds = "0"
    max_message_size = "262144"
    message_retention_seconds = "345600"
    receive_wait_time_seconds = "0"
    visibility_timeout_seconds = "30"
    name = "S3NewJsonEventAlertForLocal"
}

resource "aws_sqs_queue" "SQSQueue3" {
    delay_seconds = "0"
    max_message_size = "262144"
    message_retention_seconds = "345600"
    receive_wait_time_seconds = "0"
    visibility_timeout_seconds = "30"
    name = "monthlyJsonFetchForModelTrain"
}

resource "aws_sqs_queue_policy" "SQSQueuePolicy" {
    policy = "{\"Version\":\"2012-10-17\",\"Id\":\"PolicyForS3Events\",\"Statement\":[{\"Sid\":\"__owner_statement\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"s3.amazonaws.com\",\"AWS\":\"arn:aws:iam::853660505909:root\"},\"Action\":\"SQS:*\",\"Resource\":\"arn:aws:sqs:ap-northeast-2:853660505909:S3NewJsonEventAlert\",\"Condition\":{\"StringEquals\":{\"aws:SourceAccount\":\"853660505909\"},\"ArnLike\":{\"aws:SourceArn\":\"arn:aws:s3:::monitory-bucket\"}}}]}"
    queue_url = "https://sqs.ap-northeast-2.amazonaws.com/853660505909/S3NewJsonEventAlert"
}

resource "aws_sqs_queue_policy" "SQSQueuePolicy2" {
    policy = "{\"Version\":\"2012-10-17\",\"Id\":\"__default_policy_ID\",\"Statement\":[{\"Sid\":\"__owner_statement\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::853660505909:root\"},\"Action\":\"SQS:*\",\"Resource\":\"arn:aws:sqs:ap-northeast-2:853660505909:S3NewJsonEventAlertForLocal\"}]}"
    queue_url = "https://sqs.ap-northeast-2.amazonaws.com/853660505909/S3NewJsonEventAlertForLocal"
}

resource "aws_sqs_queue_policy" "SQSQueuePolicy3" {
    policy = "{\"Version\":\"2012-10-17\",\"Id\":\"__default_policy_ID\",\"Statement\":[{\"Sid\":\"__owner_statement\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"arn:aws:iam::853660505909:root\"},\"Action\":\"SQS:*\",\"Resource\":\"arn:aws:sqs:ap-northeast-2:853660505909:monthlyJsonFetchForModelTrain\"}]}"
    queue_url = "https://sqs.ap-northeast-2.amazonaws.com/853660505909/monthlyJsonFetchForModelTrain"
}
