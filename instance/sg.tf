#resource "aws_security_group" "sg" {
#  name        = "sg"
#  description = "sg"
#  vpc_id      = aws_vpc.sandy.id
#
#  ingress {
#    description      = "TLS from VPC"
#    from_port        = 443
#    to_port          = 443
#    protocol         = "tcp"
#    cidr_blocks      = [aws_vpc.sandy.cidr_block]
#  }
#  ingress {
#    description      = "TLS from VPC"
#    from_port        = 22
#    to_port          = 22
#    protocol         = "tcp"
#    cidr_blocks      = [aws_vpc.sandy.cidr_block]
#  }
#  ingress {
#    description      = "TLS from VPC"
#    from_port        = 80
#    to_port          = 80
#    protocol         = "tcp"
#    cidr_blocks      = [aws_vpc.sandy.cidr_block]
#  }
#  egress {
#    from_port        = 0
#    to_port          = 0
#    protocol         = "-1"
#    cidr_blocks      = ["0.0.0.0/0"]
#      }
#
#  tags = {
#    Name = "sg"
#  }
#}


resource "aws_security_group" "SG" {
  name        = "${var.name}-SG"
  description = "Allow TLG  inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-SG"
  }
}

