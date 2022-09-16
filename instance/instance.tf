resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance
#  key_name                    = "key"
  vpc_security_group_ids      = [aws_security_group.security.id]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true


    user_data = file("install_jenkins.sh")

  tags = {
    Name = "${var.name}-instance"
  }
}

resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "key"
}