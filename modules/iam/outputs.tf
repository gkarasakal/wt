output "node-group-iam-role-arn" {
  value = aws_iam_role.node-group-iam-role.arn
}

output "eks-iam-role-arn" {
  value = aws_iam_role.eks-iam-role.arn
}

output "eks-AmazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy.policy_arn
}

output "eks-AmazonEKSServicePolicy" {
  value = aws_iam_role_policy_attachment.eks-AmazonEKSServicePolicy.policy_arn
}

output "eks-AmazonEKSWorkerNodePolicy" {
  value = aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy.policy_arn
}

output "eks-AmazonEKS_CNI_Policy" {
  value = aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy.policy_arn
}

output "eks-AmazonEC2ContainerRegistryReadOnly" {
  value = aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly.policy_arn
}

output "alb_role_arn" {
  value = aws_iam_role.alb_role.arn
}

output "eks_openid_url" {
  description = "OpenID url of our k8 cluster."
  value       = aws_iam_openid_connect_provider.gokhan-wt-eks-oidc.url
}

output "eks_openid_arn" {
  description = "OpenID ARN of our k8 cluster."
  value       = aws_iam_openid_connect_provider.gokhan-wt-eks-oidc.arn
}
