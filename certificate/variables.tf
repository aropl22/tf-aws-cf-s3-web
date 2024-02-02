variable "tags" {
  type = "map"

  default = {
    managed_by = "Terraform"
    stack = "dev"
  }
}

variable "domain_name" {
  description = "Cert Domian Name"
  type        = string
}