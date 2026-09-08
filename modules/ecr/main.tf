resource "aws_ecr_repository" "this" {
  for_each = aws_ecr_repository.this
  name = each.value
  image_tag_mutability = "IMMUTABLE"
  encryption_configuration {
    encryption_type = "AES256"
  }
    image_scanning_configuration {
            scan_on_push = true
            }
    tags = var.tags
}
resource "aws_ecr_lifecycle_policy" "this" {
  for_each = aws_ecr_repository.this
  repository = each.value.name
    policy = jsonencode({ rules = [
    {
      rulePriority = 1
      description  = "Expire untagged after 7 days"
      selection    = {
        tagStatus     = "untagged"
        countType     = "sinceImagePushed"
        countUnit     = "days"
        countNumber   = 7
      }
      action       = {
        type          = "expire"
      } 
    } ]
    } )
}
output "repository_urls" {
  value = {for k,v in aws_ecr_repository.this:k=>v.repository_url}
}
output "repository_arns" {
  value = {for k,v in aws_aws_ecr_repository.this:k=>v.arn}
}


