# AOM Threshold Alarm Rule — uses huaweicloud_aom_alarm_rule (AOM v2 API)
resource "huaweicloud_aom_alarm_rule" "this" {
  name        = var.alarm_rule_name
  description = var.alarm_rule_description   # was alarm_description — wrong argument name
  alarm_level = var.alarm_rule_level

  # NOTE: There is NO alarm_enable / id_turn_on writable argument.
  # The provider always creates rules with is_turn_on=true (enabled).
  # Remove id_turn_on entirely — it caused the second error.

  # ── Metric definition ──────────────────────────────────────────────────────
  namespace           = var.metric_namespace
  metric_name         = var.metric_name
  unit                = var.metric_unit
  statistic           = var.statistic
  period              = var.period             # must be 60000 | 300000 | 900000 | 3600000 (ms)
  evaluation_periods  = var.evaluation_periods
  comparison_operator = var.comparison_operator
  threshold           = tostring(var.threshold) # provider expects a string

  # ── Dimensions (at least 1 block required) ─────────────────────────────────
  dynamic "dimensions" {
    for_each = length(var.metric_dimensions) > 0 ? var.metric_dimensions : [{ name = "hostID", value = "" }]
    content {
      name  = dimensions.value.name
      value = dimensions.value.value
    }
  }

  # ── Notifications ──────────────────────────────────────────────────────────
  alarm_action_enabled = var.alarm_smn_urn != "" ? true : false
  alarm_actions        = var.alarm_smn_urn != "" ? [var.alarm_smn_urn] : []
}