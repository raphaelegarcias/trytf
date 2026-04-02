################################################################################
# Network / Security
################################################################################
variable "vpc_id" {
  description = "ID of the VPC where the RDS instances will be deployed."
  type        = string
}

variable "subnet_id" {
  description = "ID of the DB subnet where the RDS primary instance will be deployed."
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to attach to both the primary and replica instances."
  type        = string
}

################################################################################
# Instance Identity
################################################################################
variable "rds_name" {
  description = "Name of the primary RDS instance. The replica will be named <rds_name>-replica."
  type        = string
  default     = "rds-primary"
}

variable "charging_mode" {
  description = "Charging mode for the primary RDS instance. Valid values: postPaid, prePaid."
  type        = string
  default     = "postPaid"
}

################################################################################
# Availability Zones
################################################################################
variable "primary_availability_zone" {
  description = "Availability zone for the primary (writer) RDS instance."
  type        = string
  default     = "sa-brazil-1a"
}

variable "replica_availability_zone" {
  description = "Availability zone for the read replica RDS instance."
  type        = string
  default     = "sa-brazil-1b"
}

################################################################################
# Compute — flavor is resolved dynamically via huaweicloud_rds_flavors
################################################################################
variable "db_vcpus" {
  description = "Number of vCPUs to filter for when looking up a valid RDS flavor in the current region."
  type        = number
  default     = 2
}

variable "db_memory" {
  description = "Memory size in GB to filter for when looking up a valid RDS flavor in the current region."
  type        = number
  default     = 4
}

################################################################################
# Database Engine
################################################################################
variable "db_type" {
  description = "Database engine type. Valid values: MySQL, PostgreSQL, SQLServer, MariaDB."
  type        = string
  default     = "MySQL"
}

variable "db_version" {
  description = "Database engine version, e.g. 8.0 for MySQL."
  type        = string
  default     = "8.0"
}

variable "db_password" {
  description = "Master password for the RDS primary instance."
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Database port. Defaults: MySQL 3306, PostgreSQL 5432, SQLServer 1433."
  type        = number
  default     = 3306
}

################################################################################
# Storage
################################################################################
# volume_type is resolved automatically via huaweicloud_rds_storage_types data
# source in main.tf — no need to specify it manually.

variable "volume_size" {
  description = "Storage size in GB for the primary instance. Must be a multiple of 10."
  type        = number
  default     = 40
}

################################################################################
# Backup
################################################################################
variable "backup_start_time" {
  description = "Start time of the automated backup window, e.g. 02:00-03:00."
  type        = string
  default     = "02:00-03:00"
}

variable "backup_keep_days" {
  description = "Number of days to retain automated backups (1–732)."
  type        = number
  default     = 7
}

################################################################################
# Tags
################################################################################
variable "tags" {
  description = "Map of tags to assign to the RDS resources."
  type        = map(string)
  default     = {}
}
