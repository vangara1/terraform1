resource "aws_vpc" "sandy" {
  cidr_block       = "10.0.1.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true


  tags = {
    Name = "sandy"
  }
}

