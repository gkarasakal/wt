locals {
  env     = terraform.workspace
}

variable "oidc_provider_url" {
  type    = string
}

variable "aws_load_balancer_controller_sa_name" {
  type    = string
}