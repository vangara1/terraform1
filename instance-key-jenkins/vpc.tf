resource "aws_vpc" "sandy" {
  cidr_block           = var.vpc_id
  enable_dns_hostnames = "true"
  instance_tenancy = "default"
  tags                 = {
    Name = "${var.name}-sandy"
  }
}



