resource "aws_ecr_repository" "project1" {
  name                 = "project1-repo"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}


#delete untagged images policy (https://www.linkedin.com/pulse/how-upload-docker-images-aws-ecr-using-terraform-hendrix-roa/)

resource "aws_ecr_lifecycle_policy" "default_policy" {
  repository = aws_ecr_repository.project1.name
  policy     = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Expire untagged images after 30 days",
        "selection": {
          "tagStatus": "untagged",
          "countType": "sinceImagePushed",
          "countUnit": "days",
          "countNumber": 30
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
  EOF
}
