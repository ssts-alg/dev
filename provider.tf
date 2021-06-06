provider "aws" {
  region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket         = "sureshbabu-test-123"
    key            = "terraform-dev"
    region         = "us-east-1"
    dynamodb_table = "terraform"
  }
}
