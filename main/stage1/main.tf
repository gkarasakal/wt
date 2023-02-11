module "vpc" {
  source              = "../../modules/vpc"
  env                 = local.env
  private_cidr_blocks = var.private_cidr_blocks[local.env]
  public_cidr_blocks  = var.public_cidr_blocks[local.env]
  vpc_cidr_block      = var.vpc_cidr_block[local.env]
}

module "iam" {
  source                                = "../../modules/iam"
}

module "eks" {
  source                                 = "../../modules/eks"
  eks_iam_role                           = module.iam.eks-iam-role-arn
  node-group-iam-role                    = module.iam.node-group-iam-role-arn
  subnets                                = local.public_subnet_ids
  eks-AmazonEKSServicePolicy             = module.iam.eks-AmazonEKSServicePolicy
  eks-AmazonEKSClusterPolicy             = module.iam.eks-AmazonEKSClusterPolicy
  eks-AmazonEC2ContainerRegistryReadOnly = module.iam.eks-AmazonEC2ContainerRegistryReadOnly
  eks-AmazonEKS_CNI_Policy               = module.iam.eks-AmazonEKS_CNI_Policy
  eks-AmazonEKSWorkerNodePolicy          = module.iam.eks-AmazonEKSWorkerNodePolicy
  enabled_cluster_log_types              = var.enabled_cluster_log_types
  ondemand_node_pool_instance_types      = var.ondemand_node_pool_instance_types[local.env]
  ondemand_node_pool_desired_size        = var.ondemand_node_pool_desired_size[local.env]
  ondemand_node_pool_max_size            = var.ondemand_node_pool_max_size[local.env]
  ondemand_node_pool_min_size            = var.ondemand_node_pool_min_size[local.env]
}