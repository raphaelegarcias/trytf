# Add this variable to your root variables.tf
variable "domain_name" {
  description = "Your domain name, e.g. example.com. Used by WAF and DNS modules."
  type        = string
}
