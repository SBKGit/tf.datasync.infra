resource "aws_ses_email_identity" "email" {
  for_each = var.email_addresses
  email    = each.value
}
