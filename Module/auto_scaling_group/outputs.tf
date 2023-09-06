output "asg_id" {
  value       = aws_autoscaling_group.asg.id
  description = "output will display auto scaling group id and make an entry in state file for reference"
}
output "asg_name" {
  value       = aws_autoscaling_group.asg.name
  description = "output will display auto scaling group name and make an entry in state file for reference"
}

output "launch_tmpl_version" {
  value       = aws_launch_template.launch_tmpl.latest_version
  description = "output will display latest version of launch templete created"
}

output "launch_tmpl_id" {
  value       = aws_launch_template.launch_tmpl.id
  description = "output will display id of launch templete created"
}

output "launch_tmpl_arn" {
  value       = aws_launch_template.launch_tmpl.arn
  description = "output will display arn of launch templete created"
}