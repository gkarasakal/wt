locals {
  web_traffic = {
    staging   :[
      "0.0.0.0/0"],
    production:[
      "0.0.0.0/0"]
  }
}

# Deployments variables start
variable "alb_healthcheck_interval" {
  type    = map(number)
  default = {
    staging   : 180,
    production: 60
  }
}

variable "gokhan_wt_app_image" {
  type    = string
  default = "995105043624.dkr.ecr.eu-west-1.amazonaws.com/gokhan-wt-app-staging:latest"
}
variable "gokhan_wt_app_hpa_min_replicas" {
  type    = number
  default = 1
}
variable "gokhan_wt_app_hpa_max_replicas" {
  type    = number
  default = 4
}
variable "gokhan_wt_app_hpa_cpu" {
  type    = number
  default = 80
}
variable "gokhan_wt_app_deployment_replicas" {
  type    = number
  default = 1
}
# Deployments variables end