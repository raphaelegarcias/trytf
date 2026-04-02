################################################################################
# Dynamic lookups — resolves valid flavors AND storage types for the region.
# Avoids DBS.280239 (invalid spec) and DBS.280241 (invalid storage type)
# caused by hardcoded values that differ per region (e.g. sa-brazil-1 uses
# CLOUDSSD, not ULTRAHIGH).
################################################################################

# Valid storage types for this DB engine in the current region
data "huaweicloud_rds_storage_types" "main" {
  db_type    = var.db_type
  db_version = var.db_version
}

locals {
  # Pick the first available storage type returned for this region.
  # In sa-brazil-1 this resolves to "CLOUDSSD"; in older regions to "ULTRAHIGH".
  volume_type = data.huaweicloud_rds_storage_types.main.storage_types[0].name
}

# Single-node flavor for the primary instance
data "huaweicloud_rds_flavors" "primary" {
  db_type       = var.db_type
  db_version    = var.db_version
  instance_mode = "single"
  vcpus         = var.db_vcpus
  memory        = var.db_memory
}

# Read-replica flavor
data "huaweicloud_rds_flavors" "replica" {
  db_type       = var.db_type
  db_version    = var.db_version
  instance_mode = "replica"
  vcpus         = var.db_vcpus
  memory        = var.db_memory
}

################################################################################
# RDS Primary/Writer Instance
################################################################################
resource "huaweicloud_rds_instance" "primary" {
  name              = var.rds_name
  flavor            = data.huaweicloud_rds_flavors.primary.flavors[0].name
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
  availability_zone = [var.primary_availability_zone]

  db {
    type     = var.db_type
    version  = var.db_version
    password = var.db_password
    port     = var.db_port
  }

  volume {
    type = local.volume_type
    size = var.volume_size
  }

  backup_strategy {
    start_time = var.backup_start_time
    keep_days  = var.backup_keep_days
  }

  charging_mode = var.charging_mode

  tags = var.tags
}

################################################################################
# RDS Read Replica Instance
# Note: replica volume type MUST match the primary — local.volume_type ensures this.
################################################################################
resource "huaweicloud_rds_read_replica_instance" "replica" {
  name                = "${var.rds_name}-replica"
  flavor              = data.huaweicloud_rds_flavors.replica.flavors[0].name
  primary_instance_id = huaweicloud_rds_instance.primary.id
  availability_zone   = var.replica_availability_zone
  security_group_id   = var.security_group_id

  volume {
    type = local.volume_type
  }

  tags = merge(var.tags, { role = "read-replica" })
}
