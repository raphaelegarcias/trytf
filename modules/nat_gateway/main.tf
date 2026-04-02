################################################################################
# EIP for the NAT Gateway
################################################################################
resource "huaweicloud_vpc_eip" "nat_eip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "${var.nat_name}-bandwidth"
    size        = var.bandwidth_size
    share_type  = "PER"
    charge_mode = "traffic"
  }
  tags = var.tags
}

################################################################################
# NAT Gateway
################################################################################
resource "huaweicloud_nat_gateway" "this" {
  name        = var.nat_name
  description = "NAT Gateway for Exposure Subnet outbound traffic"
  spec        = var.spec
  vpc_id      = var.vpc_id
  subnet_id   = var.subnet_id # This is the internal_network_id
  tags        = var.tags

  # Ensure the gateway isn't pulled out from under the rule
  lifecycle {
    create_before_destroy = true
  }
}

resource "huaweicloud_nat_snat_rule" "this" {
  nat_gateway_id = huaweicloud_nat_gateway.this.id
  floating_ip_id = huaweicloud_vpc_eip.nat_eip.id
  subnet_id      = var.subnet_id

  # FORCE THE ORDER: 
  # This tells Terraform: "The rule's life is tied to the gateway."
  # During 'destroy', Terraform will kill this rule BEFORE touching the gateway.
  depends_on = [
    huaweicloud_nat_gateway.this,
    huaweicloud_vpc_eip.nat_eip
  ]
}

resource "huaweicloud_nat_snat_rule" "app_snat" {
  nat_gateway_id = huaweicloud_nat_gateway.this.id
  floating_ip_id = huaweicloud_vpc_eip.nat_eip.id
  subnet_id      = var.app_subnet_id # Make sure this variable is in your variables.tf

  # This ensures both rules are wiped before the Gateway/EIP are touched
  depends_on = [
    huaweicloud_nat_gateway.this,
    huaweicloud_vpc_eip.nat_eip
  ]
}