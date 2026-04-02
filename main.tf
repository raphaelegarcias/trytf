module "vpc" {
  source   = "./modules/vpc"
  vpc_name = "vpc"
  vpc_cidr = "192.168.0.0/16"
}

module "dbsubnet" {
  source             = "./modules/dbsubnet"
  subnet_name2       = "db-subnet"
  subnet_cidr2       = "192.168.1.0/24"
  vpc_id             = module.vpc.vpc_id
  subnet_gateway_ip2 = "192.168.1.1"
  availability_zone  = "sa-brazil-1a"
}

module "appsubnet" {
  source             = "./modules/appsubnet"
  subnet_name1       = "app-subnet"
  subnet_cidr1       = "192.168.2.0/24"
  vpc_id             = module.vpc.vpc_id
  subnet_gateway_ip1 = "192.168.2.1"
  availability_zone  = "sa-brazil-1a"
}

module "exposuresubnet" {
  source             = "./modules/exposuresubnet"
  subnet_name3       = "exposure-subnet"
  subnet_cidr3       = "192.168.3.0/24"
  vpc_id             = module.vpc.vpc_id
  subnet_gateway_ip3 = "192.168.3.1"
  availability_zone  = "sa-brazil-1a"
}

module "security-group" {
  source        = "./modules/security-group"
  secgroup_name = "secgroup-1"
}

module "ecs1" {
  source       = "./modules/ecs/ecs-app-az1"
  ecs_name     = "ecs-app-az1"
  flavor       = "t6.small.1"
  os           = "Ubuntu 22.04 server 64bit"
  disk_type    = "SAS"
  disk_size    = 40
  password     = "Fat4lbonds"
  secgroup_id  = module.security-group.security_group_id
  uuid         = module.appsubnet.subnet_id1
  billing_mode = "postPaid"
}

module "ecs2" {
  source       = "./modules/ecs/ecs-app-az2"
  ecs_name     = "ecs-app-az2"
  flavor       = "t6.small.1"
  os           = "Ubuntu 22.04 server 64bit"
  disk_type    = "SAS"
  disk_size    = 40
  password     = "Fat4lbonds"
  secgroup_id  = module.security-group.security_group_id
  uuid         = module.appsubnet.subnet_id1
  billing_mode = "postPaid"
}

module "obs" {
  source      = "./modules/obs"
  bucket_name = "serpro-training-bucket"
}

module "cce" {
    source = "./modules/cce"
    vpc_id = module.vpc.vpc_id
    subnet_id = module.appsubnet.subnet_id1
    cluster_name = "master"
    flavor = "cce.s1.small"
    billing_mode = "postPaid" 
    container_network_type = "vpc-router"
}

module cce_nodes {
    source = "./modules/cce_nodes"
    cluster_id = module.cce.cce_id
    node_name = "worker1"
    flavor = "s6.large.2"
    billing_mode = "postPaid"
    admin_pass = "F4talbonds"
}

module "dcs_master_standby" {
  source    = "./modules/dcs"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.dbsubnet.subnet_id2
}

module "rds" {
  source = "./modules/rds/rds_instance"

  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.dbsubnet.subnet_id2
  security_group_id = module.security-group.security_group_id
  rds_name          = "rds-primary"
  charging_mode     = "postPaid"

  primary_availability_zone = "sa-brazil-1a"
  replica_availability_zone = "sa-brazil-1b"

  db_vcpus    = 2
  db_memory   = 4
  db_type     = "MySQL"
  db_version  = "8.0"
  db_password = var.rds_db_password
  db_port     = 3306
  volume_size = 40

  backup_start_time = "02:00-03:00"
  backup_keep_days  = 7

  tags = {
    environment = "training"
    managed_by  = "terraform"
  }
}

module "sfs_turbo" {
  source = "./modules/sfs"

  name              = "sfs-turbo"
  size              = 500
  share_type        = "STANDARD"
  availability_zone = "sa-brazil-1a"
  vpc_id            = module.vpc.vpc_id
  subnet_id         = module.dbsubnet.subnet_id2
  security_group_id = module.security-group.security_group_id

  tags = {
    environment = "training"
    managed_by  = "terraform"
  }
}

################################################################################
# EXPOSURE SUBNET — ELB + NAT Gateway
################################################################################
module "elb" {
  source = "./modules/elb"

  elb_name          = "elb-exposure"
  vpc_id            = module.vpc.vpc_id
  ipv4_subnet_id    = module.exposuresubnet.subnet_ipv4_subnet_id3
  availability_zone = "sa-brazil-1a"
  bandwidth_size    = 10
  lb_method         = "ROUND_ROBIN"

  backend_subnet_id = module.appsubnet.subnet_ipv4_subnet_id1 

  # Pass the private IPs of your ECS instances
  backend_ips = [
    module.ecs1.private_ip, 
    module.ecs2.private_ip
  ]

  tags = {
    environment = "training"
    managed_by  = "terraform"
  }
}

module "nat_gateway" {
  source = "./modules/nat_gateway"

  nat_name       = "nat-gateway"
  spec           = "1"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.exposuresubnet.subnet_id3
  app_subnet_id  = module.appsubnet.subnet_id1
  bandwidth_size = 10

  tags = {
    environment = "training"
    managed_by  = "terraform"
  }
}

/*module "waf" {
  source = "./modules/waf"

  domain          = "app.internal"
  proxy           = false
  backend_address = module.elb.elb_vip_address
  backend_port    = 80
}*/

module "dns" {
  source = "./modules/dns"

  zone_name       = "app.internal."
  zone_type       = "private"
  region          = "sa-brazil-1"
  vpc_id          = module.vpc.vpc_id
  ttl             = 300
  elb_eip_address = module.elb.elb_vip_address
  depends_on      = [module.elb]
}

################################################################################
# LTS — Log Group + Log Stream
################################################################################
module "lts" {
  source = "./modules/lts"

  log_group_name        = "lts-log-group"
  log_group_ttl_in_days = 30
  log_stream_name       = "lts-log-stream"

  tags = {
    environment = "training"
    managed_by  = "terraform"
  }
}

module "cloudeye" {
  source = "./modules/cloudeye"

  alarm_name           = "cpu-high-ecs1"
  alarm_description    = "CPU utilization is over 80%"
  alarm_enabled        = true
  alarm_smn_urn        = "" #keep empty if no SMN topic exists

  namespace            = "SYS.ECS"
  metric_name          = "cpu_util"
  
  #link it directly to your first ECS instance
  dimension_name       = "instance_id"
  #if your ECS module outputs the ID under a different name (like ecs_id), change ".id"
  dimension_value      = module.ecs1.instance_id

  #strict api values
  period               = 300       # MUST be 1, 300, 1200, 3600, 14400, or 86400
  filter               = "average" # MUST be average, max, min, sum, or variance
  comparison_operator  = ">="
  value                = 80
  unit                 = "%"       # MUST be exact string
  evaluation_periods   = 1
}


module "aom" {
  source = "./modules/aom"

  alarm_rule_name        = "aom-cpu-alarm"
  alarm_rule_description = "AOM alarm for node CPU usage"
  alarm_rule_enable      = true
  alarm_rule_level       = 2   # Major

  metric_namespace  = "PAAS.NODE"
  metric_name       = "cpuUsage"
  metric_unit       = "%"
  metric_dimensions = []   # empty → module uses default hostID sentinel

  period              = 60000
  statistic           = "average"   # renamed from filter
  comparison_operator = ">="
  threshold           = 80          # number, not string
  evaluation_periods  = 3           # renamed from count (reserved word)

  alarm_smn_urn = ""

  tags = {
    environment = "training"
    managed_by  = "terraform"
  }

  depends_on = [module.lts]
}
