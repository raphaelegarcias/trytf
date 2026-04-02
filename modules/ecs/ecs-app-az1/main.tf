data "huaweicloud_availability_zones" "myaz" {}

resource "huaweicloud_compute_instance" "ecs-app-az1" {
  name               = var.ecs_name
  image_name         = var.os
  flavor_id          = var.flavor
  charging_mode      = var.billing_mode
  system_disk_type   = var.disk_type
  system_disk_size   = var.disk_size
  admin_pass         = var.password

  security_group_ids = [var.secgroup_id]
  availability_zone  = "sa-brazil-1a"
  network {
    uuid = var.uuid
  }
}