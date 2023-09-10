output "iam_role_arn" {
  value       = aws_iam_role.iam_role.arn
  description = "output to display role arn"
}

output "iam_role_name" {
  value       = aws_iam_role.iam_role.name
  description = "output to display role name"
}

output "iam_role_id" {
  value       = aws_iam_role.iam_role.id
  description = "output to display role id"
}

output "iam_policy_name" {
  value       = aws_iam_policy.policy.name
  description = "output to display iam policy name"
}

output "iam_policy_id" {
  value       = aws_iam_policy.policy.id
  description = "output to display iam policy id"
}

output "iam_policy_arn" {
  value       = aws_iam_policy.policy.arn
  description = "output to display iam policy arn"
}