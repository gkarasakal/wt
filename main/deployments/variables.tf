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

variable "gokhan_wt_app_image" {
  type = string
}
variable "gokhan_wt_app_hpa_min_replicas" {
  type = number
}
variable "gokhan_wt_app_hpa_max_replicas" {
  type = number
}
variable "gokhan_wt_app_hpa_cpu" {
  type = number
}
variable "gokhan_wt_app_deployment_replicas" {
  type = number
}
