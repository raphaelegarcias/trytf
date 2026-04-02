resource "huaweicloud_ces_alarmrule" "this" {
  alarm_name           = var.alarm_name
  alarm_description    = var.alarm_description
  alarm_enabled        = var.alarm_enabled
  alarm_action_enabled = var.alarm_smn_urn != "" ? true : false

  metric {
    namespace   = var.namespace
    metric_name = var.metric_name
    
    # The API strictly requires this block to know WHAT it is monitoring
    dimensions {
      name  = var.dimension_name
      value = var.dimension_value
    }
  }

  condition {
    period              = var.period
    filter              = var.filter
    comparison_operator = var.comparison_operator
    value               = var.value
    unit                = var.unit
    count               = var.evaluation_periods
  }

  dynamic "alarm_actions" {
    for_each = var.alarm_smn_urn != "" ? [1] : []
    content {
      type              = "notification"
      notification_list = [var.alarm_smn_urn]
    }
  }

  dynamic "ok_actions" {
    for_each = var.alarm_smn_urn != "" ? [1] : []
    content {
      type              = "notification"
      notification_list = [var.alarm_smn_urn]
    }
  }
}