
# Output IP addresses and IDs from the main configuration
output "public_instance_ips" {
  description = "Public IP addresses of the public instances"
  value       = aws_instance.public_instance[*].public_ip
}

output "private_instance_ips" {
  description = "List of private IP addresses of instances"
  value       = aws_instance.private_instance[*].private_ip
}

output "private_instance_ids" {
  description = "List of IDs of instances"
  value       = aws_instance.private_instance[*].id
}