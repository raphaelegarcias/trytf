output "subnet_id3" {
    value = huaweicloud_vpc_subnet.subnet3.id
}
output "subnet_ipv4_subnet_id3" {
  description = "The IPv4 subnet ID (neutron) of the exposure subnet, required by ELB."
  value       = huaweicloud_vpc_subnet.subnet3.ipv4_subnet_id
}