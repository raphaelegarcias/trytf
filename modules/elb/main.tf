# 1. This asks Huawei Cloud to find the exact UUID for this flavor
data "huaweicloud_elb_flavors" "l7" {
  type = "L7"
  name = "L7_flavor.elb.s1.small"
}

################################################################################
# Dedicated Elastic Load Balancer
################################################################################
resource "huaweicloud_elb_loadbalancer" "this" {
  name              = var.elb_name
  description       = "Dedicated ELB in Exposure Subnet"
  vpc_id            = var.vpc_id
  ipv4_subnet_id    = var.ipv4_subnet_id
  availability_zone = [var.availability_zone]
  l7_flavor_id = data.huaweicloud_elb_flavors.l7.flavors[0].id
  iptype                = "5_bgp"
  bandwidth_charge_mode = "traffic"
  sharetype             = "PER"
  bandwidth_size        = var.bandwidth_size

  tags = var.tags
}

################################################################################
# HTTP Listener (port 80)
################################################################################
resource "huaweicloud_elb_listener" "http" {
  name            = "${var.elb_name}-http"
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = huaweicloud_elb_loadbalancer.this.id
}

################################################################################
# HTTPS Listener (port 443)
################################################################################


################################################################################
# Backend Server Group (HTTP)
################################################################################
resource "huaweicloud_elb_pool" "http" {
  name            = "${var.elb_name}-pool-http"
  protocol        = "HTTP"
  lb_method       = var.lb_method
  listener_id     = huaweicloud_elb_listener.http.id
  loadbalancer_id = huaweicloud_elb_loadbalancer.this.id
}

################################################################################
# Health Monitor for the pool
################################################################################
resource "huaweicloud_elb_monitor" "http" {
  pool_id        = huaweicloud_elb_pool.http.id
  protocol       = "HTTP"
  interval       = 5
  timeout        = 3
  max_retries    = 3
  url_path       = "/health"
  port           = 80
}

# Backend Members (The ECS instances in App Subnet)
################################################################################
resource "huaweicloud_elb_member" "http" {
  count         = length(var.backend_ips)
  pool_id       = huaweicloud_elb_pool.http.id
  subnet_id     = var.backend_subnet_id
  address       = var.backend_ips[count.index]
  protocol_port = 80 # The port your application is listening on
}