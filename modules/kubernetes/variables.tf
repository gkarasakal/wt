locals {
  region  = "eu-west-1"
  env     = terraform.workspace
}

variable "node-group-iam-role-arn" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "alb_role_arn" {
  type = string
}

variable "aws_load_balancer_controller_sa_name" {
  type = string
}
