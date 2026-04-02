resource "huaweicloud_networking_secgroup" "secgroup" {
  name = var.secgroup_name
}

#resource "huaweicloud_networking_secgroup_rule" "inbound" {
#  security_group_id = huaweicloud_networking_secgroup.secgroup.id
#  direction         = "ingress"
#  ethertype         = "IPv4"
#  protocol          = ""
#  remote_ip_prefix  = "0.0.0.0/0"
#}

#resource "huaweicloud_networking_secgroup_rule" "outbound" {
#  security_group_id = huaweicloud_networking_secgroup.secgroup.id
#  direction         = "egress"
# ethertype         = "IPv4"
#  protocol          = ""
#  remote_ip_prefix  = "0.0.0.0/0"
#}