output "dcs_id" {
  description = "The ID of the DCS instance."
  value       = huaweicloud_dcs_instance.instance_2.id
}

output "dcs_ip" {
  description = "The connection IP address of the DCS instance."
  # UPDATE: Changed from .ip to .private_ip to resolve the deprecation warning
  value       = huaweicloud_dcs_instance.instance_2.private_ip 
}

output "dcs_port" {
  description = "The connection port of the DCS instance."
  value       = huaweicloud_dcs_instance.instance_2.port
}

output "dcs_status" {
  description = "The current status of the DCS instance."
  value       = huaweicloud_dcs_instance.instance_2.status
}