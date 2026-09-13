terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "cloud-audit"
      Environment = "dev"
      Owner       = "Tami"
      ManagedBy   = "terraform"
    }
  }
}