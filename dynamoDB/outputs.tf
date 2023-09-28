output "dynamoDB_PrefixLookupTable_id" {
  value       = module.dynamoDB.dynamoDB_id
  description = "output to display role id"
}

output "dynamoDB_PrefixLookupTable_arn" {
  value       = module.dynamoDB.dynamoDB_arn
  description = "output to display role id"
}

output "dynamoDB_PrefixLookupTable_name" {
  value = module.dynamoDB.dynamoDB_name
}

output "dynamoDB_ErrorNotification_id" {
  value       = module.ErrorNotification.dynamoDB_id
  description = "output to display role id"
}

output "dynamoDB_ErrorNotification_arn" {
  value       = module.ErrorNotification.dynamoDB_arn
  description = "output to display role id"
}

output "dynamoDB_ErrorNotification_name" {
  value = module.ErrorNotification.dynamoDB_name
}

