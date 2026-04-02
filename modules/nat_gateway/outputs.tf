output "nat_gateway_id" {
  description = "ID of the NAT Gateway."
  value       = huaweicloud_nat_gateway.this.id
}

output "nat_gateway_name" {
  description = "Name of the NAT Gateway."
  value       = huaweicloud_nat_gateway.this.name
}

output "nat_eip_address" {
  description = "Public EIP address of the NAT Gateway."
  value       = huaweicloud_vpc_eip.nat_eip.address
}

output "nat_eip_id" {
  description = "ID of the EIP bound to the NAT Gateway."
  value       = huaweicloud_vpc_eip.nat_eip.id
}

output "snat_rule_id" {
  description = "ID of the SNAT rule."
  value       = huaweicloud_nat_snat_rule.this.id
}
