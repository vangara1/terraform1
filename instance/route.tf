
resource "aws_route_table" "RT" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.name}-RT"
  }
}


resource "aws_route_table_association" "soundeo-RT" {
  subnet_id      = var.subnet_cidr
  route_table_id = aws_route_table.RT.id
}


