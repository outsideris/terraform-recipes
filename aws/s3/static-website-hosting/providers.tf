provider "aws" {
  version = "~> 1.30"
  region  = "ap-northeast-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
}
