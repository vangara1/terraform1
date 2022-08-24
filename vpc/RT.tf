resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc.id
  route  = [
    {
      cidr_block                = var.DEFAULT_VPC
      vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
    }
  ]
  tags = {
    Name = "route"
  }
}

resource "aws_route" "route-default-vpc" {
  count = length(local.association-list)
  route_table_id = tomap(element(local.association-list, count.index))["route_table"]
  destination_cidr_block = tomap(element(local.association-list, count.index))["cidr"]
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

