output "email_identity_arn" {
  value = { for k, v in aws_ses_email_identity.email : k => v.arn }
}
