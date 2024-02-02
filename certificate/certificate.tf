# Create certificate
# To use an ACM certificate with CloudFront,
# make sure you request (or import) the certificate in the US East (N. Virginia) Region (us-east-1).

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

resource "aws_acm_certificate" "cert" {
  provider                  = aws.virginia
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"
  tags                      = var.cert_tags

  lifecycle {
    create_before_destroy = true
  }
}

# Validate certificate


resource "aws_route53_record" "validate" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.aws_route53_zone_id
}

# This resource implements a part of the validation workflow. It does not represent a real-world entity in AWS, 
# therefore changing or deleting this resource on its own has no immediate effect.

resource "aws_acm_certificate_validation" "domain" {
  provider                = aws.virginia
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.validate : record.fqdn]
}
