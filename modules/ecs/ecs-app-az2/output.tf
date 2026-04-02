output "instance_id" {
  value = huaweicloud_compute_instance.ecs-app-az2.id
}

output "private_ip" {
  value = huaweicloud_compute_instance.ecs-app-az2.access_ip_v4
}