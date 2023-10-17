output "iam_role_codebuild_arn" {
  value = module.iam_role_codebuild.iam_role_arn

}

output "codebuild_plan_arn" {
  value = module.codebuild_plan.codebuild_arn

}


output "codebuild_apply_arn" {
  value = module.codebuild_apply.codebuild_arn

}

output "codebuild_destroy_arn" {
  value = module.codebuild_destroy.codebuild_arn

}