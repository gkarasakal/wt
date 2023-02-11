locals {
  region = "eu-west-1"
}

provider "aws" {
  region              = local.region
  allowed_account_ids = [
    "995105043624",
    ""
  ]
}

terraform {
  required_version = "1.3.8"
  required_providers {
    aws = {
      version      = "4.50.0"
    }
  }
  backend "s3" {}
}
