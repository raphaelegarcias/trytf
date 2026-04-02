output "alarm_id" {
  description = "The ID of the Cloud Eye alarm rule"
  value       = huaweicloud_ces_alarmrule.this.id
}

output "alarm_name" {
  description = "The name of the Cloud Eye alarm rule"
  value       = huaweicloud_ces_alarmrule.this.alarm_name
}

output "alarm_state" {
  description = "Current state of the alarm rule"
  value       = huaweicloud_ces_alarmrule.this.alarm_state
}
