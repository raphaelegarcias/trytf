resource "huaweicloud_rds_read_replica_instance" "replica_instance" {
  name                = "test_rds_readonly_instance"
  flavor              = "rds.pg.x1.xlarge.2"
  primary_instance_id = var.primary_instance_id
  availability_zone   = var.availability_zone
  security_group_id   = var.security_group_id

  db {
    port = "8888"
  }

  volume {
    type              = "CLOUDSSD"
    size              = 50
    limit_size        = 200
    trigger_threshold = 10
  }
}