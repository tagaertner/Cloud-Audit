resource "aws_sqs_queue" "scan_dlq" {
    name    = "ScanDLQ"
}