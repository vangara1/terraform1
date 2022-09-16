resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sandy.id

  tags = {
    Name = "${var.name}-igw"
  }
}
