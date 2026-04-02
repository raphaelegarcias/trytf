################################################################################
# Private DNS Zone — resolvable inside the VPC only.
# For testing without a real public domain, zone_type = "private" works
# immediately with no domain registrar required.
################################################################################
resource "huaweicloud_dns_zone" "this" {
  name        = var.zone_name   # must end with a dot, e.g. "app.internal."
  zone_type   = var.zone_type   # "private" (no registrar needed) or "public"
  description = "Managed by Terraform"
  ttl         = var.ttl

  # Associates the private zone with the VPC so ECS/ELB inside can resolve it.
  # Only used when zone_type = "private".
  dynamic "router" {
    for_each = var.zone_type == "private" ? [1] : []
    content {
      router_id     = var.vpc_id
      router_region = var.region
    }
  }
}

################################################################################
# A Record — points the root domain to the ELB public EIP
# e.g. app.internal. → 1.2.3.4
################################################################################
resource "huaweicloud_dns_recordset" "a_record" {
  zone_id     = huaweicloud_dns_zone.this.id
  name        = var.zone_name   # root of the zone
  type        = "CNAME"
  ttl         = var.ttl
  description = "ELB public entry point"
  records     = [var.elb_eip_address]
}

################################################################################
# CNAME Record — www → root domain
# e.g. www.app.internal. → app.internal.
################################################################################
resource "huaweicloud_dns_recordset" "cname_www" {
  zone_id     = huaweicloud_dns_zone.this.id
  name        = "www.${var.zone_name}"
  type        = "CNAME"
  ttl         = var.ttl
  description = "www alias pointing to root domain"
  records     = [var.zone_name]
}

################################################################################
# CNAME Record — waf → WAF CNAME (cloud-mode WAF entry point)
# After this, WAF inspects traffic before forwarding to ELB.
# e.g. waf.app.internal. → <waf_cname_value>
################################################################################

