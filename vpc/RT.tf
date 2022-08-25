resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.vpc.id
  route  = [
    {
      cidr_block                = var.VPC_DEFAULT_ID
      vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
    }, {
      cidr_block = "0.0.0.0/0"
      vpc_peering_connection_id = ""
      nat_gateway_id = aws_nat_gateway.ngw.id
    }
  ]
  tags = {
    Name = "private-route"
  }
}

resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc.id
  route  = [
    {
      cidr_block                = var.VPC_DEFAULT_ID
      vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
    },
    {
      cidr_block = "0.0.0.0/0"
      vpc_peering_connection_id = ""
      gateway_id = aws_internet_gateway.igw.id
    }
  ]
  tags = {
    Name = "public-route"
  }
}

resource "aws_route" "route-default-vpc" {
  count                     = length(local.association-list)
  route_table_id            = tomap(element(local.association-list, count.index))["route_table"]
  destination_cidr_block    = tomap(element(local.association-list, count.index))["cidr"]
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

