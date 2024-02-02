module "dns" {
  source             = "./dns"
  domain_name        = var.domain_name
  record_domain_name = aws_cloudfront_distribution.s3_distribution.domain_name
  record_zone_id     = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
  dns_tags           = var.default_tags
}

module "certificate" {
  source = "./certificate"
  #region = "us-east-1"
  domain_name         = var.domain_name
  aws_route53_zone_id = module.dns.dns_hosted_zone_id
  cert_tags           = var.default_tags
}
