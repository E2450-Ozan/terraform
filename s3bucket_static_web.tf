provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_s3_bucket" "s3_bucket_static_web" {
  bucket = "terraform.farukgunal.net"
  acl = "public-read"
  policy = "${file("policy.json")}"  # policy from external file
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}