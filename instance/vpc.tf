resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags                 = {
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
