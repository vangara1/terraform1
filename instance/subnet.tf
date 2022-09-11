resource "aws_subnet" "sandy" {
  vpc_id                                      = aws_vpc.sandy.id
  cidr_block                                  = "10.0.1.0/24"
  availability_zone                           = "us-east-1a"
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true

  tags = {
    Name = "sandy"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.sandy.id

  tags = {
    Name = "gw"
  }
}

#resource "aws_internet_gateway_attachment" "attach" {
#  internet_gateway_id = aws_internet_gateway.gw.id
#  vpc_id              = aws_vpc.sandy.id
#}


resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.sandy.id

  route {
    cidr_block = aws_subnet.sandy.cidr_block
       gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "rt"
  }
}



resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.sandy.id
  route_table_id = aws_route_table.rt.id
}