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



resource "tls_private_key" "instance-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "inst-key" {
  key_name   = "login"
  public_key = tls_private_key.instance-key.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOT
      sudo echo '${tls_private_key.instance-key.private_key_pem}' > ./vi'${login}'.pem
      sudo chmod 400 ./'${login}'.pem
    EOT
  }
}