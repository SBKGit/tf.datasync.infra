resource "aws_codebuild_project" "codebuild" {
  name           = "${var.name}-${var.env}-codebuild"
  build_timeout  = var.build_timeout
  queued_timeout = var.queued_timeout
  service_role   = var.role_arn
  artifacts {
    type = var.artifacts_type
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "env_name"
      value = var.env
    }
    environment_variable {
      name  = "source_dir"
      value = var.source_dir
    }

  }
  source {
    type            = var.source_type
    location        = var.github_url
    git_clone_depth = 1
    buildspec       = var.build_spec
  }


}