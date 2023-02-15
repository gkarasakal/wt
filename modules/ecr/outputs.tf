output "wt_app_ecr_repository_name" {
  description = "WT App ECR repository name"
  value = aws_ecr_repository.wt-app.name
}

output "wt_app_ecr_repository_url" {
  description = "WT App ECR repository URL"
  value = aws_ecr_repository.wt-app.repository_url
}

output "wt_app_ecr_repository_id" {
  description = "WT App ECR repository ID"
  value = aws_ecr_repository.wt-app.registry_id
}