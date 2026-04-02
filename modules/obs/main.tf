resource "huaweicloud_obs_bucket" "bucket_datasus" {
  bucket = var.bucket_name
  acl    = "private" # 

  # Define a classe de armazenamento
  storage_class = "STANDARD"

  force_destroy = true

  tags = {
    foo = "bar"
    env = "production"
  }
}