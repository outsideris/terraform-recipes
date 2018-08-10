resource "aws_route53_record" "website" {
  zone_id = "${aws_route53_zone.YOUR_ZONE_NAME.zone_id}"
  name    = "your.domain"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.website.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.website.hosted_zone_id}"
    evaluate_target_health = false
  }
}
