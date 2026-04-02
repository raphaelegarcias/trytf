# LTS Log Group
resource "huaweicloud_lts_group" "this" {
  group_name  = var.log_group_name
  ttl_in_days = var.log_group_ttl_in_days

  tags = var.tags
}

# LTS Log Stream (inside the log group)
resource "huaweicloud_lts_stream" "this" {
  group_id    = huaweicloud_lts_group.this.id
  stream_name = var.log_stream_name

  tags = var.tags
}
