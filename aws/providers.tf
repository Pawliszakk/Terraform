terraform {
  required_version = ">= 1.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}


# export AWS_ACCESS_KEY_ID="AKIA..."
# export AWS_SECRET_ACCESS_KEY="..."
