output "efs_dns_name" {
  description = "DNS name of the provisioned AWS EFS"
  value       = aws_efs_mount_target.main.*.dns_name
}

output "swarm_manager_ips" {
  description = "The manager nodes public ipv4 adresses"

  # value       = ["${var.eip_allocation_id == "null" ? aws_instance.manager.*.public_ip : local.manager_public_ip_list}"]
  value = [local.manager_public_ip_list]
}

output "swarm_manager_ips_private" {
  description = "The manager nodes private ipv4 adresses"
  value       = [aws_instance.manager.*.private_ip]
}

output "swarm_worker_ips" {
  description = "The worker nodes public ipv4 adresses"
  value       = [aws_instance.worker.*.public_ip]
}

output "swarm_worker_ips_private" {
  description = "The worker nodes private ipv4 adresses"
  value       = [aws_instance.worker.*.private_ip]
}
