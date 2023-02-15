module "kubernetes" {
  source                               = "../../modules/kubernetes"
  cluster_name                         = data.terraform_remote_state.gokhan-wt-eks-remote.outputs.cluster-name
  node-group-iam-role-arn              = data.terraform_remote_state.gokhan-wt-eks-remote.outputs.node-group-iam-role-arn
  vpc_id                               = data.terraform_remote_state.gokhan-wt-eks-remote.outputs.vpc_id
  alb_role_arn                         = data.terraform_remote_state.gokhan-wt-eks-remote.outputs.alb_role_arn
  aws_load_balancer_controller_sa_name = var.aws_load_balancer_controller_sa_name
}
