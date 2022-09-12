resource "aws_vpc" "vpc" {
  cidr_block       = "190.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  instance_tenancy = "default"
  tags = {
    Name = "vpc"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
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
