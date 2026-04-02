variable "name" {
  description = "Name of the SFS Turbo file system."
  type        = string
  default     = "sfs-turbo"
}

variable "size" {
  description = "Capacity of the SFS Turbo file system in GB. Minimum is 500 GB."
  type        = number
  default     = 500
}

variable "share_type" {
  description = "File system type. Valid values: STANDARD (HDD-backed) or PERFORMANCE (SSD-backed)."
  type        = string
  default     = "STANDARD"
}

variable "availability_zone" {
  description = "Availability zone where the SFS Turbo file system will be deployed."
  type        = string
  default     = "sa-brazil-1a"
}

variable "vpc_id" {
  description = "ID of the VPC to which the SFS Turbo file system belongs."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet (network) where SFS Turbo will allocate its private IPs."
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group attached to the SFS Turbo file system."
  type        = string
}

variable "tags" {
  description = "Map of tags to assign to the SFS Turbo file system."
  type        = map(string)
  default     = {}
}