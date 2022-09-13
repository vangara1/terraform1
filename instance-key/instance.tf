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
  key_name          = "key"

  tags = {
    Name = "instance"
  }
}

resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = tls_private_key.rsa.public_key_pem
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content = tls_private_key.rsa.private_key_pem
  filename = "tf-key"
}