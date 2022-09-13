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
  key_name      = "terra"
  tags          = {
    Name = "instance"
  }
}

resource "null_resource" "jenkins" {
  provisioner "local-exec" {
    command  = [
      "sudo yum install -y jenkins java-11-openjdk-devel", "sudo yum -y install wget",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key", "sudo yum upgrade -y",
      "sudo yum install jenkins -y", "sudo systemctl start jenkins",
    ]
  }
}