resource "aws_cloudfront_origin_access_identity" "website" {
  comment = "website demo Cloudfront"
}

resource "aws_cloudfront_distribution" "website" {
  origin {
    domain_name = "${aws_s3_bucket.website.bucket_domain_name}"
    origin_path = ""
    origin_id   = "${aws_s3_bucket.website.id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.website.cloudfront_access_identity_path}"
    }
  }

  aliases             = ["your.domain"]
  comment             = "your.domain"
  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"
  http_version        = "http2"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${aws_s3_bucket.website.id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    max_ttl                = 360
    default_ttl            = 60
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "${aws_acm_certificate.website.arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}
