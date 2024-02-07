variable "domain_name" {
  description = "Website Domian Name"
  type        = string
}

variable "aliases" {
  description = "cf aliases"
  type        = list(string)
}

variable "default_tags" {
  type = map(any)
  default = {
    managed_by : "Terraform",
    stack : "test",
    project : "1"
  }
}