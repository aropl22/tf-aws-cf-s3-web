resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = var.dns_tags
}

resource "aws_route53_record" "allias1" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  alias {
    name                   = var.record_domain_name
    zone_id                = var.record_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "allias2" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = var.record_domain_name
    zone_id                = var.record_zone_id
    evaluate_target_health = false
  }
}