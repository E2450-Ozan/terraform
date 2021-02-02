provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_eip" "web" {
  instance = "${aws_instance.web.id}"
  vpc = true
}