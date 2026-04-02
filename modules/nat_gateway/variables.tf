variable "nat_name" {
  description = "Name of the NAT Gateway."
  type        = string
  default     = "nat-gateway"
}

variable "spec" {
  description = "NAT Gateway spec. 1=small(10k), 2=medium(50k), 3=large(200k), 4=xlarge(1M) SNAT connections."
  type        = string
  default     = "1"
}

variable "vpc_id" {
  description = "ID of the VPC where the NAT Gateway will be deployed."
  type        = string
}

variable "subnet_id" {
  description = "ID of the exposure subnet where the NAT Gateway resides."
  type        = string
}

variable "bandwidth_size" {
  description = "EIP bandwidth size in Mbps for the NAT Gateway."
  type        = number
  default     = 10
}

variable "tags" {
  description = "Map of tags to assign to NAT Gateway resources."
  type        = map(string)
  default     = {}
}

variable "app_subnet_id" {}