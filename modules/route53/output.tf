
output "route53_nameservers" {
  value = aws_route53_zone.main.name_servers
}
output "vpc_id" {
  value = aws_vpc.main.id
}