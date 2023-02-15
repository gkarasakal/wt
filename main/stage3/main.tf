module "deployments" {
  source                             = "./../deployments"
  alb_healthcheck_interval           = var.alb_healthcheck_interval[local.env]
  vpc_id                             = data.terraform_remote_state.gokhan-wt-eks-remote.outputs.vpc_id
  web_traffic                        = local.web_traffic[local.env]
  gokhan_wt_app_deployment_replicas  = var.gokhan_wt_app_deployment_replicas
  gokhan_wt_app_hpa_cpu              = var.gokhan_wt_app_hpa_cpu
  gokhan_wt_app_hpa_max_replicas     = var.gokhan_wt_app_hpa_max_replicas
  gokhan_wt_app_hpa_min_replicas     = var.gokhan_wt_app_hpa_min_replicas
  gokhan_wt_app_image                = var.gokhan_wt_app_image
}
