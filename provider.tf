terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.36.0"
    }
  }
}


# Configure the HuaweiCloud Provider
provider "huaweicloud" {
  region     = "sa-brazil-1"
  access_key = "HPUAHDEOHOH1UB6PQSCE"
  secret_key = "sUbtuvIEkpqMpOwFhZlHaYMDUxe6Jx7TAbUloytE"
}
