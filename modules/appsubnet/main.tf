data "huaweicloud_availability_zones" "myaz" {}

resource "huaweicloud_vpc_subnet" "subnet1" {
  name              = var.subnet_name1
  cidr              = var.subnet_cidr1
  gateway_ip        = var.subnet_gateway_ip1
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zone
}