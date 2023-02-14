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
# Deployments variables end