locals {
  env = terraform.workspace
}

variable "eks_iam_role" {
  type = string
}

variable "node-group-iam-role" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "eks-AmazonEKSServicePolicy" {
  type = string
}

variable "eks-AmazonEKSClusterPolicy" {
  type = string
}

variable "eks-AmazonEKSWorkerNodePolicy" {
  type = string
}

variable "eks-AmazonEKS_CNI_Policy" {
  type = string
}

variable "eks-AmazonEC2ContainerRegistryReadOnly" {
  type = string
}

variable "enabled_cluster_log_types" {
  type = list(string)
}

variable "ondemand_node_pool_instance_types" {
  type = list(string)
}

variable "ondemand_node_pool_desired_size" {
  type = number
}

variable "ondemand_node_pool_max_size" {
  type = number
}

variable "ondemand_node_pool_min_size" {
  type = number
}
