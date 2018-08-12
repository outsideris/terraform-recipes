resource "aws_route53_zone" "example_com" {
  name = "example.com"
}

resource "aws_route53_record" "www_example_com" {
  zone_id = "${aws_route53_zone.example_com.zone_id}"
  name    = "www.example.com"
  type    = "A"
  ttl     = "300"
  records = ["TARGET_IP"]
}
