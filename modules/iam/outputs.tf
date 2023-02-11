output "node-group-iam-role-arn" {
  value = aws_iam_role.node-group-iam-role.arn
}

output "eks-iam-role-arn" {
  value = aws_iam_role.eks-iam-role.arn
}
