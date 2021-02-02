provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_default_vpc" "default" {
  tags = {
    "Name" = "Default VPC"
  }
}