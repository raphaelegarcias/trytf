variable "alarm_rule_name" {
  description = "Name of the AOM alarm rule (1–128 chars, letters/digits/-/_)."
  type        = string
}

variable "alarm_rule_description" {
  description = "Human-readable description of the alarm rule (0–256 chars)."
  type        = string
  default     = ""
}

variable "alarm_rule_level" {
  description = "Alarm severity: 1=Critical, 2=Major, 3=Minor, 4=Info."
  type        = number
  default     = 2
}

variable "alarm_rule_enable" {
  description = "Whether to enable the alarm rule (id_turn_on)."
  type        = bool
  default     = true
}

# ── Metric ──────────────────────────────────────────────────────────────────

variable "metric_namespace" {
  description = "AOM metric namespace. E.g.: PAAS.NODE, PAAS.CONTAINER, SYS.ECS."
  type        = string
}

variable "metric_name" {
  description = "AOM metric name. E.g.: cpuUsage, memUsedPercent."
  type        = string
}

variable "metric_unit" {
  description = "Unit of the metric. E.g.: %, Byte, Count."
  type        = string
  default     = "%"
}

variable "metric_dimensions" {
  description = <<-EOT
    Dimension filters for the alarm. Each object must have 'name' and 'value'.
    The provider requires at least 1 dimensions block; when this list is empty
    the module falls back to { name = "hostID", value = "" } (all hosts).
  EOT
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# ── Threshold condition ──────────────────────────────────────────────────────

variable "period" {
  description = "Statistical period in seconds. Common values: 60, 300, 900, 3600."
  type        = number
  default     = 60
}

variable "statistic" {
  description = "Aggregation method. Valid values: average, sum, min, max, sampleCount."
  type        = string
  default     = "average"
}

variable "comparison_operator" {
  description = "Comparison operator. Valid values: >=, <=, >, <."
  type        = string
  default     = ">="
}

variable "threshold" {
  description = "Numeric threshold value that triggers the alarm."
  type        = number
}

variable "evaluation_periods" {
  description = "Number of consecutive periods the metric must breach the threshold before an alarm fires."
  type        = number
  default     = 3
}

# ── Notifications ────────────────────────────────────────────────────────────

variable "alarm_smn_urn" {
  description = "SMN topic URN for alarm notifications. Leave empty to disable."
  type        = string
  default     = ""
}

# ── Tags ─────────────────────────────────────────────────────────────────────

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}

