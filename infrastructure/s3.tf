resource "aws_s3_bucket" "reports" {
  bucket = "cloud-audit-reports-061361823578" # must be globally unique — reuse your account-id suffix
}

resource "aws_s3_bucket_lifecycle_configuration" "reports" {
  bucket = aws_s3_bucket.reports.id

  rule {
    id     = "expire-after-7-days"
    status = "Enabled"

    filter {} # empty = applies to all objects

    expiration {
      days = 7
    }
  }
}