resource "aws_security_group" "security" {
  name        = "Security"
  description = "Allow TLG  inbound traffic"
  vpc_id      = aws_vpc.sandy.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-security"
  }
}

resource "aws_key_pair" "inst-key" {
  key_name   = "login"
  public_key = tls_private_key.instance-key.public_key_openssh
}

resource "tls_private_key" "instance-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
provisioner "local-exec" {
  command = <<-EOT
      sudo echo '${tls_private_key.instance-key.private_key_pem}' > ./vi'${login}'.pem
      sudo chmod 400 ./'${login}'.pem
    EOT
}