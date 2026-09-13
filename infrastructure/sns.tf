resource "aws_sns_topic" "cloud_audit_alerts" {
  name = "cloud-audit-alerts"
}

resource "aws_sns_topic_subscription" "cloud_audit_alerts_email" {
  topic_arn = aws_sns_topic.cloud_audit_alerts.arn
  protocol  = "email"
  endpoint  = "tamiagaertner+cloudaudit@gmail.com"
}