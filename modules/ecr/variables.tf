locals {
  env = terraform.workspace
}

variable "ecr_lifecycle_image_count" {
  type = number
}