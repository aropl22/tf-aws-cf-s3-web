variable "domain_name" {
  description = "Website Domian Name"
  type        = string
}

variable "dns_tags" {
  type = map(any)
}

variable "record_domain_name" {
  type = string
}

variable "record_zone_id" {
  type = string
}