provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_security_group" "allow_tls" {
  ingress = [ {
    cidr_blocks = [ "1.2.3.4/32" ]
    from_port = 443
    protocol = "tcp"
    to_port = 443
  } ]
  # egress for outbound traffic, any protocol from any port
  egress = [ {       
    from_port = 0
    protocol = "-1"
    to_port = 0
  } ]
}