resource "aws_ecr_repository" "ecr_repo" {
  name         = var.ecr_repo_name
  force_delete = var.ecr_force_delete
  tags         = var.ecr_tags
}
#Copies the image from Public ECR Gallery to Private ECR  https://registry.terraform.io/providers/bsquare-corp/skopeo2/latest/docs/resources/copy

resource "skopeo2_copy" "image_copy" {
  depends_on        = [aws_ecr_repository.ecr_repo]
  source_image      = "docker://public.ecr.aws/akeyless/serverless-gateway:${var.image_tag}"
  destination_image = "docker://${aws_ecr_repository.ecr_repo.repository_url}:${var.image_tag}"
}