output "datasync_instance_role_name" {
  value       = aws_iam_role.datasync_instance_role.name
  description = "AWS Account id to which internet gateway is associated."
}

output "datasync_instance_role_arn" {
  value       = aws_iam_role.datasync_instance_role.arn
  description = "AWS Account id to which internet gateway is associated."
}

output "datasync_instance_id" {
  value       = aws_instance.datasync_instance.id
  description = "AWS Account id to which internet gateway is associated."
}

output "datasync_instance_private_ip" {
  value       = aws_instance.datasync_instance.private_ip
  description = "AWS Account id to which internet gateway is associated."
}

output "datasync_instance_private_dns" {
  value       = aws_instance.datasync_instance.private_dns
  description = "AWS Account id to which internet gateway is associated."
}

output "datasync_vpc_endpoint_id" {
  value       = aws_datasync_agent.datasync_agent.id
  description = "AWS Account id to which internet gateway is associated."
}

output "datasync_vpc_endpoint_arn" {
  value       = aws_datasync_agent.datasync_agent.arn
  description = "AWS Account id to which internet gateway is associated."
}

output "datasync_vpc_endpoint_network_interface_ids" {
  value       = aws_vpc_endpoint.datasync_agent_endpoint.network_interface_ids
  description = "AWS Account id to which internet gateway is associated."
}

output "datasync_agent_arn" {
  value       = aws_datasync_agent.datasync_agent.arn
  description = "AWS Account id to which internet gateway is associated."
}

output "datasync_agent_id" {
  value       = aws_datasync_agent.datasync_agent.id
  description = "AWS Account id to which internet gateway is associated."
}