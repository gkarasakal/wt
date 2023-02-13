locals {
  env     = terraform.workspace
}

variable "oidc_provider_url" {
  type    = string
}