################################################################################
# Primary Instance Outputs
################################################################################
output "rds_primary_id" {
  description = "ID of the primary RDS instance."
  value       = huaweicloud_rds_instance.primary.id
}

output "rds_primary_name" {
  description = "Name of the primary RDS instance."
  value       = huaweicloud_rds_instance.primary.name
}

output "rds_primary_private_ips" {
  description = "Private IP address(es) of the primary RDS instance."
  value       = huaweicloud_rds_instance.primary.private_ips
}

output "rds_primary_port" {
  description = "Database port of the primary RDS instance."
  value       = huaweicloud_rds_instance.primary.db[0].port
}

output "rds_primary_status" {
  description = "Current status of the primary RDS instance."
  value       = huaweicloud_rds_instance.primary.status
}

################################################################################
# Read Replica Outputs
################################################################################
output "rds_replica_id" {
  description = "ID of the read replica RDS instance."
  value       = huaweicloud_rds_read_replica_instance.replica.id
}

output "rds_replica_name" {
  description = "Name of the read replica RDS instance."
  value       = huaweicloud_rds_read_replica_instance.replica.name
}

output "rds_replica_private_ips" {
  description = "Private IP address(es) of the read replica RDS instance."
  value       = huaweicloud_rds_read_replica_instance.replica.private_ips
}

output "rds_replica_status" {
  description = "Current status of the read replica RDS instance."
  value       = huaweicloud_rds_read_replica_instance.replica.status
}
