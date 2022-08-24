resource "aws_subnet" "subnets" {
  depends_on        = [aws_vpc_ipv4_cidr_block_association.addon]
  count             = length(var.SUBNETS)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.SUBNETS, count.index )
  avaliability_zone = element(var.AZs, count.index)

  tags = {
    Name = "subnet-${count.index}"
  }
}

resource "aws_route_table_association" "assoc" {
  count = length(length(aws_subnet.subnets.*.id))
  subnet_id      = element(aws_subnet.subnets.*.id,count.index )
  route_table_id = aws_route_table.route.id
}
