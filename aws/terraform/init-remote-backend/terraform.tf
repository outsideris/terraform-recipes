terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket         = "your.bucket.name.for.tfstate"
    key            = "path/to/terraform.tfstate"
    region         = "YOUR_REGION"                     // e.g. ap-northeast-1
    encrypt        = true
    dynamodb_table = "YOUR_DYNAMODB_LOCK_TABLE_NAME"
    acl            = "bucket-owner-full-control"
  }
}
