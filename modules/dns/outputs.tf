output "zone_id" {
  description = "ID of the DNS zone."
  value       = huaweicloud_dns_zone.this.id
}

output "zone_name" {
  description = "Name of the DNS zone."
  value       = huaweicloud_dns_zone.this.name
}

output "a_record_id" {
  description = "ID of the root A record."
  value       = huaweicloud_dns_recordset.a_record.id
}

output "cname_www_id" {
  description = "ID of the www CNAME record."
  value       = huaweicloud_dns_recordset.cname_www.id
}

