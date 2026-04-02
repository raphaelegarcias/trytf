data "huaweicloud_availability_zones" "myaz" {}

resource "huaweicloud_vpc_subnet" "subnet2" {
  name              = var.subnet_name2
  cidr              = var.subnet_cidr2
  gateway_ip        = var.subnet_gateway_ip2
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zone
}