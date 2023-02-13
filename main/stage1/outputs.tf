/*
  VPC
*/
output "vpc_id" {
  value = module.vpc.vpc_id
}

/*
  IAM
*/
output "node-group-iam-role-arn" {
  value = module.iam.node-group-iam-role-arn
}

output "eks-iam-role-arn" {
  value = module.iam.eks-iam-role-arn
}

/*
  Kubernetes Cluster
*/
output "cluster-name" {
  value = module.eks.cluster-name
}

output "eks-cluster-endpoint" {
  value = module.eks.eks-cluster-endpoint
}

/*
  ECR
*/
output "ecr_repository_name" {
  value = module.ecr.wt_app_ecr_repository_name
}

output "ecr_repository_url" {
  value = module.ecr.wt_app_ecr_repository_url
}
