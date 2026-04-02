output "instance_id" {
  value = huaweicloud_compute_instance.ecs-app-az1.id
}
output "private_ip" {
  value = huaweicloud_compute_instance.ecs-app-az1.access_ip_v4
}