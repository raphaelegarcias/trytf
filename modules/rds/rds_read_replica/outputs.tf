output "replica_id" {
  description = "The ID of the RDS read replica instance"
  value       = huaweicloud_rds_read_replica_instance.replica_instance.id
}

output "replica_name" {
  description = "The name of the RDS read replica instance"
  value       = huaweicloud_rds_read_replica_instance.replica_instance.name
}

output "replica_status" {
  description = "The status of the RDS read replica instance"
  value       = huaweicloud_rds_read_replica_instance.replica_instance.status
}

output "replica_private_ips" {
  description = "The private IP addresses of the read replica"
  value       = huaweicloud_rds_read_replica_instance.replica_instance.private_ips
}

output "replica_db_port" {
  description = "The database port of the read replica"
  value       = huaweicloud_rds_read_replica_instance.replica_instance.db[0].port
}

output "replica_volume_size" {
  description = "The current volume size of the read replica (GB)"
  value       = huaweicloud_rds_read_replica_instance.replica_instance.volume[0].size
}