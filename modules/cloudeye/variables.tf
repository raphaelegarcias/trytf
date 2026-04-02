variable "alarm_name" {
  description = "Name of the Cloud Eye alarm rule"
  type        = string
  default     = "cloudeye-alarm"
}

variable "alarm_description" {
  description = "Description of the alarm rule"
  type        = string
  default     = "Alarm rule managed by Terraform"
}

variable "alarm_enabled" {
  description = "Whether the alarm rule is enabled"
  type        = bool
  default     = true
}

variable "alarm_action_enabled" {
  description = "Whether alarm actions (notifications) are enabled"
  type        = bool
  default     = true
}

# Metric definition
variable "namespace" {
  description = "Metric namespace (e.g. SYS.ECS, SYS.RDS)"
  type        = string
  default     = "SYS.ECS"
}

variable "metric_name" {
  description = "Metric name to monitor (e.g. cpu_util, mem_util)"
  type        = string
  default     = "cpu_util"
}

variable "dimensions" {
  description = "List of metric dimensions ({name, value} maps)"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# Condition
variable "period" {
  description = "Monitoring period in seconds (1, 300, 1200, 3600, 14400, 86400)"
  type        = number
  default     = 300
}

variable "filter" {
  description = "Data rollup method: average, max, min, sum, variance"
  type        = string
  default     = "average"
}

variable "comparison_operator" {
  description = "Comparison operator: >, >=, <, <="
  type        = string
  default     = ">="
}

variable "value" {
  description = "Threshold value that triggers the alarm"
  type        = number
  default     = 80
}

variable "unit" {
  description = "Unit of the metric (e.g. %, Byte, Count)"
  type        = string
  default     = "%"
}

variable "evaluation_periods" {
  description = "Number of consecutive periods before alarm triggers"
  type        = number
  default     = 2
}

# Alarm action — SMN topic ARN
variable "alarm_action_type" {
  description = "Notification type: notification or autoscaling"
  type        = string
  default     = "notification"
}

variable "alarm_smn_urn" {
  description = "SMN topic URN to send alarm notifications to"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to Cloud Eye resources"
  type        = map(string)
  default     = {}
}

variable "dimension_name" {
  description = "The name of the dimension (e.g., instance_id)"
  type        = string
  default     = "instance_id"
}

variable "dimension_value" {
  description = "The actual ID of the resource to monitor"
  type        = string
}