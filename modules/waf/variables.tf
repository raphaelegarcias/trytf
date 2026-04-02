variable "domain" {
  description = "Domain name to protect. For private DNS testing use your zone name without trailing dot, e.g. 'app.internal'"
  type        = string
  default     = "app.internal"
}

variable "proxy" {
  description = "Whether a proxy is deployed in front of WAF. false = WAF is the first entry point."
  type        = bool
  default     = false
}

variable "backend_address" {
  description = "IP address of the backend server — typically the ELB VIP address."
  type        = string
}

variable "backend_port" {
  description = "Port of the backend server."
  type        = number
  default     = 80
}
