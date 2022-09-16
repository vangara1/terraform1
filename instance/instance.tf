resource "aws_s3_bucket" "bucket" {
  bucket = "terra-07009"
  key    = "bucket/file"
  region = "us-east-1"
  tags = {
    Name        = "${var.name}-bucket"
  }
}


resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance
  key_name                    = var.inst-key
  vpc_security_group_ids      = [aws_security_group.security.id]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true


  provisioner "local-exec" {
    command = <<-EOT
#!/bin/bash
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install java-11-openjdk-devel -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
    EOT
  }

  tags = {
    Name = "${var.name}-instance"
  }
}



resource "tls_private_key" "instance-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "inst-key" {
  key_name   = var.inst-key
  public_key = tls_private_key.instance-key.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOT
      sudo echo '${tls_private_key.instance-key.private_key_pem}' > ./'${var.inst-key}'.pem
      sudo chmod 400 ./'${var.inst-key}'.pem
    EOT
  }
}






