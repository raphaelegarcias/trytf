resource "huaweicloud_dcs_instance" "instance_2" {
  name               = "redis_name"
  engine             = "Redis"
  engine_version     = "5.0"
  capacity           = 4
  flavor             = "redis.ha.xu1.large.r2.4"
  # The first is the primary availability zone (cn-north-1a),
  # and the second is the standby availability zone (cn-north-1b).
  availability_zones = ["sa-brazil-1a", "sa-brazil-1b"]
  password           = "F4talbonds"
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id

  charging_mode = "postPaid"

  backup_policy {
    backup_type = "auto"
    save_days   = 3
    backup_at   = [1, 3, 5, 7]
    begin_at    = "02:00-04:00"
  }

  whitelists {
    group_name = "test-group1"
    ip_address = ["192.168.10.100", "192.168.0.0/24"]
  }
  whitelists {
    group_name = "test-group2"
    ip_address = ["172.16.10.100", "172.16.0.0/24"]
  }

  parameters {
    id    = "1"
    name  = "timeout"
    value = "500"
  }
  parameters {
    id    = "3"
    name  = "hash-max-ziplist-entries"
    value = "4096"
  }
}