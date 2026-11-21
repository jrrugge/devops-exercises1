resource "aws_sqs_queue" "dlq" {
  name                      = "message-analysis-dlq"
  message_retention_seconds = 1209600 # 14 days
  sqs_managed_sse_enabled   = true
}

resource "aws_sqs_queue" "analysis" {
  name                       = "message-analysis-queue" # resource name the app expects for comms
  visibility_timeout_seconds = 120
  sqs_managed_sse_enabled    = true

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 5
  })
}