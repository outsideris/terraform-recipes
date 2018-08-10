resource "aws_acm_certificate" "website" {
  // To use an ACM Certificate with Amazon CloudFront,
  // you must request or import the certificate in the US East (N. Virginia) region.
  provider = "aws.virginia"

  domain_name       = "your.domain"
  validation_method = "EMAIL"

  lifecycle {
    create_before_destroy = true
  }
}
