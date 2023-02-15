resource "aws_eks_cluster" "gokhan-eks-cluster" {
  name     = "Gokhan-EKS-Cluster-${local.env}"
  role_arn = var.eks_iam_role
  enabled_cluster_log_types = var.enabled_cluster_log_types

  vpc_config {
    subnet_ids = var.subnets
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    var.eks-AmazonEKSClusterPolicy,
    var.eks-AmazonEKSServicePolicy,
  ]

  tags = {
    Name         = "Gokhan EKS Cluster ${local.env}"
    Project      = "WT"
    Environment  = local.env
  }
}

resource "aws_eks_node_group" "gokhan-eks-ondemand-node-group" {
  cluster_name    = aws_eks_cluster.gokhan-eks-cluster.name
  node_group_name = "gokhan-eks-ondemand-worker-nodes"
  node_role_arn   = var.node-group-iam-role
  subnet_ids      = var.subnets
  instance_types  = var.ondemand_node_pool_instance_types
  disk_size       = 20

  scaling_config {
    desired_size = var.ondemand_node_pool_desired_size
    max_size     = var.ondemand_node_pool_max_size
    min_size     = var.ondemand_node_pool_min_size
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    "lifecycle" = "OnDemand"
  }

  tags = {
    Name = "Gokhan OnDemand EKS Worker Nodes"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.eks-AmazonEKSWorkerNodePolicy,
    var.eks-AmazonEKS_CNI_Policy,
    var.eks-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_autoscaling_group_tag" "eks_node_name" {
  autoscaling_group_name = aws_eks_node_group.gokhan-eks-ondemand-node-group.resources[0].autoscaling_groups[0].name
    tag {
    key   = "Name"
    value = "Gokhan EKS OnDemand Worker Node ${local.env}"
    propagate_at_launch = true
  }
  depends_on = [
    aws_eks_node_group.gokhan-eks-ondemand-node-group
  ]
}
