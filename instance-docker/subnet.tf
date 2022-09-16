resource "aws_subnet" "subnet" {
  vpc_id                                      = aws_vpc.sandy.id
  availability_zone                           = var.az[0]
  cidr_block                                  = var.subnet_cidr[0]
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch                     = "true"

  tags = {
    Name = "${var.name}-subnet"
  }
}


resource "aws_subnet" "subnet-1" {
  vpc_id                                      = aws_vpc.sandy.id
  availability_zone                           = var.az[1]
  cidr_block                                  = var.subnet_cidr[1]
  enable_resource_name_dns_a_record_on_launch = "true"
  map_public_ip_on_launch                     = "true"

  tags = {
    Name = "${var.name}-subnet-1"
  }
}










