resource "aws_cloudwatch_log_group" "cloud_audit_lambda" {
  name              = "/aws/lambda/${aws_lambda_function.cloud_audit_function.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "CloudAuditLambdaErrorAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  threshold           = 3

  dimensions = {
    FunctionName = aws_lambda_function.cloud_audit_function.function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "duration_alarm" {
  alarm_name          = "CloudAuditDurationAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Maximum"
  threshold           = 25000

  dimensions = {
    FunctionName = aws_lambda_function.cloud_audit_function.function_name
  }
}


resource "aws_cloudwatch_metric_alarm" "throttle_alarm" {
  alarm_name          = "CloudAuditThrottleAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  dimensions = {
    FunctionName = aws_lambda_function.cloud_audit_function.function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "dynamodb_throttle_alarm" {
  alarm_name          = "CloudAuditDynamoDBThrottleAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ThrottledRequests"
  namespace           = "AWS/DynamoDB"
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  dimensions = {
    TableName = aws_dynamodb_table.cloud_audit.name
  }
}

resource "aws_cloudwatch_metric_alarm" "api_gateway_4xx_alarm" {
  alarm_name          = "CloudAuditApiGateway4xxAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "4XXError"
  namespace           = "AWS/ApiGateway"
  period              = 300
  statistic           = "Sum"
  threshold           = 10

  dimensions = {
    ApiId = aws_apigatewayv2_api.cloud_audit_api_gateway.id
  }
}

resource "aws_cloudwatch_metric_alarm" "api_gateway_5xx_alarm" {
  alarm_name          = "CloudAuditApiGateway5xxAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "5XXError"
  namespace           = "AWS/ApiGateway"
  period              = 300
  statistic           = "Sum"
  threshold           = 1

  dimensions = {
    ApiId = aws_apigatewayv2_api.cloud_audit_api_gateway.id
  }
}