terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

}

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "instance" {
  ami           = "ami-002070d43b0a4f171"
  instance_type = "t2.micro"
  key_name      = "key"
  tags          = {
    Name = "instance"
  }
}

resource "null_resource" "jenkins" {
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y jenkins java-11-openjdk-devel", "sudo yum -y install wget",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key", "sudo yum upgrade -y",
      "sudo yum install jenkins -y", "sudo systemctl start jenkins",
    ]
    sleep        = "500"
  }
  connection {
    type        = "ssh"
    host        = aws_subnet.subnet.cidr_block
    user        = "centos"
    private_key = tls_private_key.rsa.private_key_pem
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