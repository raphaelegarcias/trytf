output "elb_id" {
  description = "ID of the Elastic Load Balancer."
  value       = huaweicloud_elb_loadbalancer.this.id
}

output "elb_name" {
  description = "Name of the Elastic Load Balancer."
  value       = huaweicloud_elb_loadbalancer.this.name
}

output "elb_vip_address" {
  description = "Private VIP address of the ELB."
  value       = huaweicloud_elb_loadbalancer.this.ipv4_address
}

output "elb_http_listener_id" {
  description = "ID of the HTTP listener."
  value       = huaweicloud_elb_listener.http.id
}

output "elb_pool_http_id" {
  description = "ID of the HTTP backend server pool."
  value       = huaweicloud_elb_pool.http.id
}