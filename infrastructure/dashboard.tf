resource "aws_cloudwatch_dashboard" "cloud_audit_dashboard" {
  dashboard_name = "Cloud-Audit-Application-Dashboard"

  dashboard_body = jsonencode({
    widgets = concat(
      # 1. Six real alarm widgets, arranged in a 3-column grid
      [
        for index, alarm in [
          { title = "Lambda Errors", arn = aws_cloudwatch_metric_alarm.lambda_errors.arn },
          { title = "Lambda Duration", arn = aws_cloudwatch_metric_alarm.duration_alarm.arn },
          { title = "Lambda Throttles", arn = aws_cloudwatch_metric_alarm.throttle_alarm.arn },
          { title = "DynamoDB Throttles", arn = aws_cloudwatch_metric_alarm.dynamodb_throttle_alarm.arn },
          { title = "API Gateway 4xx", arn = aws_cloudwatch_metric_alarm.api_gateway_4xx_alarm.arn },
          { title = "API Gateway 5xx", arn = aws_cloudwatch_metric_alarm.api_gateway_5xx_alarm.arn },
          ] : {
          type   = "metric"
          width  = 8
          height = 4
          x      = (index % 3) * 8
          y      = floor(index / 3) * 4
          properties = {
            title  = alarm.title
            view   = "timeSeries"
            region = "us-east-1"
            annotations = {
              alarms = [alarm.arn]
            }
          }
        }
      ],

      # 2. Custom application metrics (scanners don't exist yet, so this
      # will show "no data" until they're built and start emitting EMF).
      [{
        type   = "metric"
        width  = 12
        height = 6
        x      = 0
        y      = 8
        properties = {
          title  = "Application Metrics"
          region = "us-east-1"
          view   = "timeSeries"
          metrics = [
            # <-- THIS is where `color` goes: as the 5th element in each
            # metric's array, inside that trailing options object.
            ["CloudAudit/Application", "FindingsPerScan", { "label" : "Findings per Scan", "color" : "#d13212" }],
            ["CloudAudit/Application", "TotalEstimatedWaste", { "label" : "Total Estimated Waste ($)", "color" : "#1f77b4" }]
          ]
          period = 300
          stat   = "Sum"
        }
      }],

      # 3. Log-based widget, pointed at the real Lambda log group
      [{
        type   = "log"
        width  = 12
        height = 6
        x      = 12
        y      = 8
        properties = {
          title  = "Recent System Errors"
          region = "us-east-1"
          query  = "SOURCE '${aws_cloudwatch_log_group.cloud_audit_lambda.name}' | fields @timestamp, @message | filter @message like /Exception|Error/ | sort @timestamp desc | limit 20"
          view   = "table"
        }
      }]
    )
  })
}
