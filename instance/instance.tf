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
  key           = "terra"
  user_data = "${file("install_jenkins.sh")}"

  tags = {
    Name = "${var.ENV}"
  }
}
