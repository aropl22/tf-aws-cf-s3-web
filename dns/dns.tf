## DNS zone doesn't exists - local.existing_dns_zone = false
resource "aws_route53_zone" "main" {
  count = var.dns_zone_config ? 0 : 1
  name = var.domain_name

  tags = {
    ManagedBy = var.name_managed_by
    Stack     = var.name_stack
  }
}

resource "aws_route53_record" "allias1" {
  count = var.dns_zone_config ? 0 : 1 
  zone_id = aws_route53_zone.main[count.index].zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    #zone_id                = aws_s3_bucket.s3-web.hosted_zone_id
    evaluate_target_health = false
  }
}
## END DNS zone doesn't exists - local.existing_dns_zone = false

## DNS zone exists - local.existing_dns_zone = true
data "aws_route53_zone" "existing" {
   count = var.dns_zone_config ? 1 : 0
  name = "${var.domain_name}"
}

resource "aws_route53_record" "allias2" {
  count = var.dns_zone_config? 1 : 0
  zone_id = data.aws_route53_zone.existing[count.index].zone_id
  name    = "${var.domain_name}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    #zone_id                = aws_s3_bucket.s3-web.hosted_zone_id
    evaluate_target_health = false
  }
}
## END DNS zone exists - local.existing_dns_zone = true