terraform {
  required_version = ">=0.12"
  backend "s3" {
    bucket = "terra-0700009"
    key = "bucket/state"
    region = "us-east-1"
  }
}


resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance
  key_name                    = "terra"
  vpc_security_group_ids      = [aws_security_group.security.id]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true


  provisioner "local-exec" {
    command = <<-EOT
#!/bin/bash
sudo yum update -y
sudo yum -y install epel-release
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
sudo docker pull nginx
sudo docker run -d -p 8080:80 --name my-nginx nginx
sudo docker ps
sudo docker ps -a
    EOT
  }

  tags = {
    Name = "${var.name}-instance"
  }
}





