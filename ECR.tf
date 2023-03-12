resource "aws_ecr_repository" "ECR" {
  name                 = var.ECR_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}