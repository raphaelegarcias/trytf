resource "huaweicloud_cce_node" "node" {
  cluster_id        = var.cluster_id
  name              = var.node_name
  flavor_id         = var.flavor
  availability_zone = "sa-brazil-1a"
  charging_mode     = var.billing_mode
  password          = var.admin_pass

  # FIX 1: Specify the OS to ensure compatibility
  os = "EulerOS 2.9"

  # FIX 2: Explicitly set the runtime to avoid bootstrap hangs
  runtime = "containerd"

  root_volume {
    size       = 40
    volumetype = "SAS"
  }
  
  data_volumes {
    size       = 100
    volumetype = "SAS" 
  }
# Dentro do resource "huaweicloud_cce_node" "node"
# Remova a linha do private_ip e use:

  /*iptype                = "5_bgp"
  bandwidth_charge_mode = "traffic"
  sharetype             = "PER"
  bandwidth_size        = 10*/
}