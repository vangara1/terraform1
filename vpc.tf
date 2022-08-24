resource "aws_vpc" "redflag" {
  cidr_block           = "190.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = {
    Name = "redflag"
  }
}
