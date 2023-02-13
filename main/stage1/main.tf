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

module "ecr" {
  source                     = "../../modules/ecr"
  ecr_lifecycle_image_count  = var.ecr_lifecycle_image_count[local.env]
}

module "rds" {
  source                      = "../../modules/rds"
  vpc_id                      = local.vpc_id
  public_subnet_ids           = local.public_subnet_ids
  private_subnet_ids          = local.private_subnet_ids
  allowed_ips                 = local.allowed_ips[local.env]
  rds_cluster_id              = var.rds_cluster_id
  engine_mode                 = var.engine_mode
  engine_version              = var.engine_version
  db_name                     = var.db_name
  min_capacity                = var.min_capacity[local.env]
  max_capacity                = var.max_capacity[local.env]
  deletion_protection         = var.deletion_protection[local.env]
  db_snapshot_identifier      = var.db_snapshot_identifier[local.env]
  rds_backup_retention_period = var.rds_backup_retention_period[local.env]
}