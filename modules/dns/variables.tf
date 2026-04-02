variable "zone_name" {
  description = "DNS zone name. Must end with a dot. Use a fake domain for private testing, e.g. 'app.internal.'"
  type        = string
  default     = "app.internal."
}

variable "zone_type" {
  description = "Zone type. 'private' works without a real domain (VPC-internal only). 'public' requires a registered domain."
  type        = string
  default     = "private"
}

variable "ttl" {
  description = "Default TTL in seconds for all record sets."
  type        = number
  default     = 300
}

variable "vpc_id" {
  description = "VPC ID to associate with the private zone. Required when zone_type = private."
  type        = string
  default     = ""
}

variable "region" {
  description = "Huawei Cloud region. Used for the private zone VPC association."
  type        = string
  default     = "sa-brazil-1"
}

variable "elb_eip_address" {
  description = "Public EIP address of the ELB. Used for the A record."
  type        = string
}

