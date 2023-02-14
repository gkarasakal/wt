locals {
  env    = terraform.workspace
  region = "eu-west-1"
}

variable "alb_healthcheck_interval" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "web_traffic" {
  type = list(string)
}