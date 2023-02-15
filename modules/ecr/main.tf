resource "aws_ecr_repository" "wt-app" {
  name                 = "gokhan-wt-app-${local.env}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    service      = "microservice-gokhan-wt-app-${local.env}"
    Project      = "WT"
    Environment  = local.env
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.wt-app.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 10,
            "description": "Expire images older than 30 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 20,
            "description": "Keep last 2 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.ecr_lifecycle_image_count}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF

  depends_on = [aws_ecr_repository.wt-app]
}