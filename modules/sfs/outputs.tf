output "sfs_turbo_id" {
  description = "ID of the SFS Turbo file system."
  value       = huaweicloud_sfs_turbo.this.id
}

output "sfs_turbo_name" {
  description = "Name of the SFS Turbo file system."
  value       = huaweicloud_sfs_turbo.this.name
}

output "sfs_turbo_export_location" {
  description = "NFS mount path of the SFS Turbo file system (e.g. 192.168.1.x:/)."
  value       = huaweicloud_sfs_turbo.this.export_location
}

output "sfs_turbo_size" {
  description = "Capacity of the SFS Turbo file system in GB."
  value       = huaweicloud_sfs_turbo.this.size
}