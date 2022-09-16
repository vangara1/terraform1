resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance
  key_name                    = "terra"
  vpc_security_group_ids      = [aws_security_group.security.id]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true


    user_data = <<EOF
          #!/bin/bash
          sudo yum update -y
          sudo yum install docker -y
          sudo systemctl enable docker
          sudo systemctl start docker
          sudo docker pull nginx
          sudo docker run -p 8080:80 --name=my-nginx nginx
      EOF

  tags = {
    Name = "${var.name}-instance"
  }
}
#
#output "private-ip" {
#  value = aws_instance.instance.private_ip
#}

#resource "aws_key_pair" "key" {
#  key_name   = "key"
#  public_key = tls_private_key.rsa.public_key_openssh
#}
#resource "tls_private_key" "rsa" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}
#resource "local_file" "key" {
#  content  = tls_private_key.rsa.private_key_pem
#  filename = "key"
#}