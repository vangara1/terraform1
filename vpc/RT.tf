resource "aws_route_table" "redflag-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "example"
  }
}


resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnets.id
  route_table_id = aws_route_table.redflag-rt.id
}