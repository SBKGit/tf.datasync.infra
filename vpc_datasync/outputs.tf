output "datasync_instance_role_name" {
  value = aws_iam_role.datasync_instance_role.name

}

output "datasync_instance_role_arn" {
  value = aws_iam_role.datasync_instance_role.arn

}

output "datasync_instance_id" {
  value = aws_instance.datasync_instance.id

}

output "datasync_instance_private_ip" {
  value = aws_instance.datasync_instance.private_ip

}

output "datasync_instance_private_dns" {
  value = aws_instance.datasync_instance.private_dns

}

output "datasync_vpc_endpoint_id" {
  value = aws_datasync_agent.datasync_agent.id

}

output "datasync_vpc_endpoint_arn" {
  value = aws_datasync_agent.datasync_agent.arn

}

output "datasync_vpc_endpoint_network_interface_ids" {
  value = aws_vpc_endpoint.datasync_agent_endpoint.network_interface_ids

}

output "datasync_agent_arn" {
  value = aws_datasync_agent.datasync_agent.arn

}

output "datasync_agent_id" {
  value = aws_datasync_agent.datasync_agent.id

}