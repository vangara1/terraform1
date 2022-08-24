resource "aws_vpc_peering_connection" "peer" {
  peer_vpc_id   = aws_vpc.vpc.id
  vpc_id        = var.VPC_DEFAULT_ID
  auto_accept = true
  tags = {
    Name = "${var.ENV}-vpc-to-default-vpc"
  }
}
