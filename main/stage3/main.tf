module "deployments" {
  source                     = "./../deployments"
  alb_healthcheck_interval   = var.alb_healthcheck_interval[local.env]
  vpc_id                     = data.terraform_remote_state.gokhan-wt-eks-remote.outputs.vpc_id
  web_traffic                = local.web_traffic[local.env]
}
