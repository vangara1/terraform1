resource "aws_subnet" "subnet" {
  vpc_id                                      = aws_vpc.sandy.id
  availability_zone                           = var.az
  cidr_block                                  = var.subnet_cidr
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch                     = "true"

  tags = {
    Name = "${var.name}-subnet"
  }
}



















