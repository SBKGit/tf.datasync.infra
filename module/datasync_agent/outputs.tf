output "datasync_agent_id" {
  value       = aws_datasync_agent.datasync_agent.id
  description = "output to display subnet id"
}

output "datasync_agent_arn" {
  value = aws_datasync_agent.datasync_agent.arn
}
