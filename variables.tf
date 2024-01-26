variable "domain_name" {
  description = "Website Domian Name"
  type        = string
}
/*
variable "s3-logs" {
  description = "Logs bucket"
  type        = string
}
*/
variable "aliases" {
  description = "cf aliases"
  type        = list(string)
}
