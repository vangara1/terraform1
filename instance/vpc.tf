#resource "aws_vpc" "sandy" {
#  cidr_block       = "10.0.0.0/16"
#  instance_tenancy = "default"
#  enable_dns_hostnames = true
#
#
#  tags = {
#    Name = "sandy"
#  }
#}


resource "aws_vpc" "vpc" {
  cidr_block       = "190.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  instance_tenancy = "default"
  tags = {
    Name = "${var.name}-vpc"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-igw"
  }
}

#
#resource "aws_internet_gateway_attachment" "soundeo-igw-attachment" {
#  internet_gateway_id = aws_internet_gateway.soundeo-igw.id
#  vpc_id              = aws_vpc.soundeo-vpc.id
#  tags = {
#    Name = "soundeo-igw-attachment"
#  }
#}
