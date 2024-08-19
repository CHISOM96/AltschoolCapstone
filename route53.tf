# Route 53 Hosted Zone
resource "aws_route53_zone" "main" {
  name = "chisomn.com"
}

# Route 53 Record Set for the application
resource "aws_route53_record" "app" {
  zone_id = aws_route53_zone.main.id
  name    = "shop.chisomn.com"
  type    = "A"

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}
