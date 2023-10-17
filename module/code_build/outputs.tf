output "codebuild_id" {
  value       = aws_codebuild_project.codebuild.id
  description = "output to display id"
}

output "codebuild_arn" {
  value       = aws_codebuild_project.codebuild.arn
  description = "output to display id"
}