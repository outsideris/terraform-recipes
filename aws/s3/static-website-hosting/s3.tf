resource "aws_s3_bucket" "website" {
  bucket = "your.domain"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.website.json}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

data "aws_iam_policy_document" "website" {
  statement {
    actions = ["s3:GetObject"]

    // This ARN should be hard coded. Otherwise, it is be circular reference.
    resources = ["arn:aws:s3:::your.domain/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.website.iam_arn}"]
    }
  }
}
