variable "rds_db_password" {
  description = "Master password for the RDS primary instance."
  type        = string
  sensitive   = true
}