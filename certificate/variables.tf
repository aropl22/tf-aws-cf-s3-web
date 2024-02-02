variable "domain_name" {
  description = "Cert Domian Name"
  type        = string
}

variable "cert_tags" {
  type = map(any)
}

variable "aws_route53_zone_id" {
  type = string
}