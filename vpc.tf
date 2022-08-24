resource "aws_vpc" "redflag" {
  cidr_block           = "170.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = {
    Name = "redflag"
  }
}

resource "aws_subnet" "redflag-sub" {
  vpc_id                                         = aws_vpc.redflag.id
  cidr_block                                     = "170.0.0.0/17"
  availability_zone                              = us-east-1b
  enable_resource_name_dns_aaaa_record_on_launch = true
  enable_resource_name_dns_a_record_on_launch    = true

  tags = {
    Name = "redflag-sub"
  }
}