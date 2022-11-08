# For an ECR Repository
resource "aws_ecr_repository" "main-repo" {
  name                 = "main-repo"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository_policy" "main-repo-policy" {
  repository = aws_ecr_repository.main-repo.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}

output "registry_id" {
  description = "The account ID of the registry holding the repository."
  value = main-repo.repository.registry_id
}
output "repository_url" {
  description = "The URL of the repository."
  value = main-repo.repository.repository_url
}