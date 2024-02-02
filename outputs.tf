output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.s3_distribution.id
}

output "CF_https" {
  value = "https://${aws_cloudfront_distribution.s3_distribution.domain_name}/"
}

output "https" {
  value = "https://${var.domain_name}/"
}