################################################################################
# Terraform & Provider Requirements
# (Declared at the module level so the module is self-documenting.
#  The root provider configuration takes precedence at runtime.)
################################################################################
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.63.0"
    }
  }
}
