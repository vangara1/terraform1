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
  ami           = var.ami
  instance_type = var.ec2-type
  key_name      = var.key

  tags = {
    Name = "${var.ENV}"
  }
}
