/*
  Kubernetes Cluster
*/
output "cluster-name" {
  value = aws_eks_cluster.gokhan-eks-cluster.name
}

output "eks-cluster-endpoint" {
  value = aws_eks_cluster.gokhan-eks-cluster.endpoint
}

output "eks-cluster-certificate-authority" {
  value = aws_eks_cluster.gokhan-eks-cluster.certificate_authority.0.data
}

output "eks_kubeconfig" {
  value = local.kubeconfig
  depends_on = [
    aws_eks_cluster.gokhan-eks-cluster
  ]
}
