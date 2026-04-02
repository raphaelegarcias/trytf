variable "elb_name" {
  description = "Name of the Elastic Load Balancer."
  type        = string
  default     = "elb-exposure"
}

variable "vpc_id" {
  description = "ID of the VPC where the ELB will be deployed."
  type        = string
}

variable "ipv4_subnet_id" {
  description = "IPv4 network ID of the exposure subnet (huaweicloud_vpc_subnet.subnet.id, NOT the subnet's ipv4_subnet_id attribute)."
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the ELB."
  type        = string
  default     = "sa-brazil-1a"
}

variable "bandwidth_size" {
  description = "EIP bandwidth size in Mbps."
  type        = number
  default     = 10
}

variable "lb_method" {
  description = "Load balancing algorithm. Valid values: ROUND_ROBIN, LEAST_CONNECTIONS, SOURCE_IP."
  type        = string
  default     = "ROUND_ROBIN"
}

variable "tags" {
  description = "Map of tags to assign to ELB resources."
  type        = map(string)
  default     = {}
}

variable "backend_ips" {
  description = "List of private IPs from the ECS instances"
  type        = list(string)
  default     = []
}

variable "backend_subnet_id" {
  description = "The IPv4 Subnet ID of the App Subnet (where servers live)"
  type        = string
}