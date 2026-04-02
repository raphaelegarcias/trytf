resource "huaweicloud_sfs_turbo" "this" {
  name              = var.name
  size              = var.size
  share_proto       = "NFS"
  share_type        = var.share_type
  availability_zone = var.availability_zone
  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id

  tags = var.tags
}