terraform {
  backend "s3" {
    bucket       = "cloud-audit-tfstate-061361823578"
    key          = "cloud-audit/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
