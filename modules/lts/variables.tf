variable "log_group_name" {
  description = "Name of the LTS log group"
  type        = string
  default     = "lts-log-group"
}

variable "log_group_ttl_in_days" {
  description = "Log retention period in days for the log group"
  type        = number
  default     = 30
}

variable "log_stream_name" {
  description = "Name of the LTS log stream"
  type        = string
  default     = "lts-log-stream"
}

variable "tags" {
  description = "Tags to apply to LTS resources"
  type        = map(string)
  default     = {}
}
