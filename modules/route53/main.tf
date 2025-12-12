# Public Hosted Zone
resource "aws_route53_zone" "main" {
  name = "tejas.buzz"
}

# Route53 Alias → ALB
resource "aws_route53_record" "alb_alias" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "tejas.buzz"
  type    = "A"

  alias {
    name                   = aws_lb.application_load_balancer.dns_name
    zone_id                = aws_lb.application_load_balancer.zone_id
    evaluate_target_health = false
  }
}

