resource "aws_route53_zone" "example_com" {
  name = "example.com"
}

resource "aws_route53_record" "" {
  zone_id = "${aws_route53_zone.example_com.zone_id}"
  name    = "www.example.com"
  type    = "A"

  ttl     = "300"
  records = ["TARGET_IP"]
}

resource "aws_route53_record" "www_example_com_case_a" {
  zone_id = "${aws_route53_zone.example_com.zone_id}"
  name    = "www.example.com"
  type    = "CNAME"
  ttl     = 60
  records = ["TARGET_DOMAIN"]                         // e.g. cloudfront distribution

  weighted_routing_policy {
    weight = 10 // this weight / sum of the weights for all records
  }

  set_identifier = "case-a"
}

resource "aws_route53_record" "www_example_com_case_b" {
  zone_id = "${aws_route53_zone.example_com.zone_id}"
  name    = "www.example.com"
  type    = "CNAME"
  ttl     = 60
  records = ["TARGET_DOMAIN"]                         // e.g. cloudfront distribution

  weighted_routing_policy {
    weight = 10 // this weight / sum of the weights for all records
  }

  set_identifier = "case-b"
}
