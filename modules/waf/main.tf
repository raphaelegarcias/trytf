resource "huaweicloud_waf_policy" "this" {
  name = "${replace(var.domain, ".", "-")}-policy"
}

resource "huaweicloud_waf_domain" "this" {
  domain    = var.domain
  proxy     = var.proxy
  charging_mode = "postPaid"
  policy_id = huaweicloud_waf_policy.this.id

  server {
    client_protocol = "HTTP"
    server_protocol = "HTTP"
    address         = var.backend_address
    port            = var.backend_port
  }
}
#terraform import huaweicloud_waf_policy.this ee9fb954857e4a6890ee4f0e543d5ba0
