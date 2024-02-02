variable "domain_name" {
  description = "Website Domian Name"
  type        = string
}

variable "name_managed_by" {
  description = "Managed By"
  type        = string
  default      = "Terraform"
}

variable "name_stack" {
  description = "Name of the Stack"
  type        = string
  default = "Dev"
}

variable "dns_zone_config" {
  description = "Create new DNS zone"
  type        = bool
  default     = false
} 
