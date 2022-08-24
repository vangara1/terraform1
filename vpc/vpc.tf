resource "aws_vpc" "vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.ENV
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "addon" {
  count      = length(var.VPC_CIDR_ADDON)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.VPC_CIDR_ADDON, count.index)
}
