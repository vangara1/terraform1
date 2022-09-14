
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.sandy.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "RT"
  }
}


resource "aws_route_table_association" "soundeo-RT" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.RT.id
}


