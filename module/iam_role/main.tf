data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = var.service_name
    }
  }
}

#
resource "aws_iam_role" "iam_role" {
  name                = "${var.name}-iam-role"
  path                = var.path_name
  managed_policy_arns = [aws_iam_policy.policy.arn, var.managed_arn]
  assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json
}


resource "aws_iam_policy" "policy" {
  name = "${var.name}-iam-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = var.action_items
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}