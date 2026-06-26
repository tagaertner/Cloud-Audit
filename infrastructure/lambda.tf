resource "aws_lambda_function" "cloud_audit_function"{
    function_name = "CloudAuditFunction"
    runtime       = "java21"
    handler       = "io.quarkus.amazon.lambda.runtime.QuarkusStreamHandler::handleRequest"
    filename      = "../target/function.zip"
    role          = aws_iam_role.lambda_exec_role.arn
    memory_size   = 512
    timeout       = 30
    publish       = true

    tracing_config {
        mode = "Active"
    }

    snap_start {
        apply_on = "PublishedVersions"
    }

    dead_letter_config {
        target_arn = aws_sqs_queue.scan_dlq.arn
    }

}

resource "aws_lambda_alias" "live"{
    name             =  "live"
    function_name    = aws_lambda_function.cloud_audit_function.function_name
    function_version = aws_lambda_function.cloud_audit_function.version
}