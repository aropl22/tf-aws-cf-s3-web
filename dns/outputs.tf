output "dns_hosted_zone_arn" {
  value = aws_route53_zone.main.arn
}

output "dns_hosted_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "dns_hosted_zone_name_servers" {
  value = aws_route53_zone.main.name_servers
}

output "Ddns_hosted_zone_primary_name_server" {
  value = aws_route53_zone.main.primary_name_server
}

output "dns_hosted_zone_tags" {
  value = aws_route53_zone.main.tags_all
}