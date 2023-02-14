locals {
  region = "eu-west-1"
  env = terraform.workspace
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
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
  backend "s3" {}
}

data "external" "aws_iam_authenticator" {
  program = ["sh", "-c", "aws-iam-authenticator token -i ${data.terraform_remote_state.gokhan-wt-eks-remote.outputs.cluster-name} | jq -r -c .status"]
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.gokhan-wt-eks-remote.outputs.eks-cluster-endpoint
  token                  = data.external.aws_iam_authenticator.result.token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.gokhan-wt-eks-remote.outputs.eks-cluster-certificate-authority)
}

provider "kubectl" {
  host                   = data.terraform_remote_state.gokhan-wt-eks-remote.outputs.eks-cluster-endpoint
  token                  = data.external.aws_iam_authenticator.result.token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.gokhan-wt-eks-remote.outputs.eks-cluster-certificate-authority)
  load_config_file       = "false"
}

data "terraform_remote_state" "gokhan-wt-eks-remote" {
  backend = "s3"
  config  = {
    key            = "env:/${local.env}/terraform.tfstate"
    bucket         = "gokhan-wt-${local.env}-terraform-state-bucket"
    region         = local.region
    dynamodb_table = "gokhan-wt-${local.env}-infra-state-lock"
    encrypt        = true
  }
}
