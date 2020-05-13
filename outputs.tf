output "efs_dns_name" {
  description = "DNS name of the provisioned AWS EFS"
  value       = aws_efs_file_system.main.*.dns_name
}

output "global_accelerator_dns_name" {
  description = "DNS name of the AWS Global Accelerator"
  value       = aws_globalaccelerator_accelerator.web.*.dns_name
}

output "global_accelerator_static_ip_addresses" {
  description = "Static IP addresses associated with the AWS Global Accelerator"
  value       = aws_globalaccelerator_accelerator.web.*.ip_sets
}

output "loadbalancer_dns_name" {
  description = "DNS name of the loadbalancer"
  value       = aws_lb.web.dns_name
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
