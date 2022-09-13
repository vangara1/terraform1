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
  ami             = "ami-002070d43b0a4f171"
  instance_type = "t2.micro"
  key_name      = "terra"
  user_data = <<EOF
#! /bin/bash
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum update -y
sudo yum install jenkins java-1.8.0-openjdk-devel -y
sudo systemctl daemon-reload
sudo systemctl start jenkins && sudo systemctl status jenkins
EOF


tags = {
    Name = "TRIAL"
  }
}
