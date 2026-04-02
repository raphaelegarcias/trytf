resource "huaweicloud_cce_cluster" "cluster" {
  name                   = var.cluster_name
  flavor_id              = var.flavor
  vpc_id                 = var.vpc_id
  subnet_id              = var.subnet_id
  charging_mode          = var.billing_mode  
  container_network_type = var.container_network_type

  container_network_cidr = "10.0.0.0/16"
  service_network_cidr   = "172.16.0.0/16"
  
}