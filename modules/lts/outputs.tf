output "log_group_id" {
  description = "The ID of the LTS log group"
  value       = huaweicloud_lts_group.this.id
}

output "log_group_name" {
  description = "The name of the LTS log group"
  value       = huaweicloud_lts_group.this.group_name
}

output "log_stream_id" {
  description = "The ID of the LTS log stream"
  value       = huaweicloud_lts_stream.this.id
}

output "log_stream_name" {
  description = "The name of the LTS log stream"
  value       = huaweicloud_lts_stream.this.stream_name
}
