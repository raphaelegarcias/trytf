data "huaweicloud_availability_zones" "myaz" {}

resource "huaweicloud_vpc_subnet" "subnet3" {
  name              = var.subnet_name3
  cidr              = var.subnet_cidr3
  gateway_ip        = var.subnet_gateway_ip3
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zone
}