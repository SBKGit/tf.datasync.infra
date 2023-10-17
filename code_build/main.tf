#backend configuration
terraform {
  backend "s3" {
  }
}

module "iam_role_codebuild" {
  source       = "../module/iam_role"
  name         = "codebuild"
  env          = var.env
  aws_region   = var.aws_region
  path_name    = "/app/"
  service_name = ["codebuild.amazonaws.com"]
  managed_arn  = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  action_items = ["ec2:DescribeInstances",
    "ec2:CreateNetworkInterface",
    "ec2:AttachNetworkInterface",
    "ec2:DescribeNetworkInterfaces",
    "autoscaling:CompleteLifecycleAction",
    "ec2:DeleteNetworkInterface",
  "logs:*"]
}

module "codebuild_plan" {
  source      = "../module/code_build"
  name        = "terraform-plan"
  role_arn    = module.iam_role_codebuild.iam_role_arn
  aws_region  = var.aws_region
  env         = var.env
  source_type = "GITHUB"
  build_spec  = "build_jobs/buildspec_plan.yml"
  source_dir  = "vpc_1 vpc_2"
  github_url  = "https://github.com/SBKGit/tf.datasync.infra.git"

}

module "codebuild_apply" {
  source      = "../module/code_build"
  name        = "terraform-apply"
  role_arn    = module.iam_role_codebuild.iam_role_arn
  aws_region  = var.aws_region
  env         = var.env
  source_type = "GITHUB"
  build_spec  = "build_jobs/buildspec_apply.yml"
  source_dir  = "vpc_1 vpc_2"
  github_url  = "https://github.com/SBKGit/tf.datasync.infra.git"

}

module "codebuild_destroy" {
  source      = "../module/code_build"
  name        = "terraform-destroy"
  role_arn    = module.iam_role_codebuild.iam_role_arn
  aws_region  = var.aws_region
  env         = var.env
  source_type = "GITHUB"
  build_spec  = "build_jobs/buildspec_destroy.yml"
  source_dir  = "vpc_1 vpc_2"
  github_url  = "https://github.com/SBKGit/tf.datasync.infra.git"

}