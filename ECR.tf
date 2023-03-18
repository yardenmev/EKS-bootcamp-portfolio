resource "aws_ecr_repository" "ECR" {
  name                 = var.ECR_name
  image_tag_mutability = "MUTABLE"
  # repository_force_delete = true
}