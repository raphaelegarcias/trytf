output "alarm_rule_id" {
  description = "The ID of the AOM alarm rule"
  value       = huaweicloud_aom_alarm_rule.this.id
}

output "alarm_rule_name" {
  description = "The name of the AOM alarm rule"
  value       = huaweicloud_aom_alarm_rule.this.name
}

output "alarm_rule_status" {
  description = "Current status of the AOM alarm rule"
  value       = huaweicloud_aom_alarm_rule.this.alarm_level
}
# Remove this output entirely — huaweicloud_aom_log_metric_rule does not exist in this provider.
# output "log_metric_rule_id" { ... }

