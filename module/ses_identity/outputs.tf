output "email_identities" {
  value = aws_ses_email_identity.email.*.email
}