resource "aws_s3_bucket" "terraform-state" {
  bucket = "your.bucket.name"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
