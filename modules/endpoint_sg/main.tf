// modules/endpoint_sg/main.tf

resource "aws_security_group" "pl_endpoint" {
  name        = var.endpoint_sg_name
  description = "SG for PrivateLink endpoint ENIs"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow HTTPS from within VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr_block]
    ipv6_cidr_blocks = []
  }

  egress {
    description      = "Allow all outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}