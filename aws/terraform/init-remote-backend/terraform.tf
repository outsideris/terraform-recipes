terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket         = "test.kr.sideeffect.terraform.state"
    key            = "path/to/terraform.tfstate"
    region         = "ap-northeast-1"                     // e.g. ap-northeast-1
    encrypt        = true
    dynamodb_table = "OutsiderTestTerraformStateLock"
    acl            = "bucket-owner-full-control"
  }
}
