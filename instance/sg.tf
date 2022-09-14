resource "aws_security_group" "SG" {
  name        = "SG"
  description = "Allow TLG  inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = aws_vpc.vpc.cidr_block
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = aws_vpc.vpc.cidr_block
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = aws_vpc.vpc.cidr_block
  }
  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = aws_vpc.vpc.cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG"
  }
}

data "aws_security_group" "selected" {
  name = "SG"
}

#
#output "aws_security_group" {
#  value = aws_security_group.SG.id
#}
#
#resource "aws_network_interface_sg_attachment" "sg_attachment" {
#  security_group_id    = module.aws_security_group.security_group_id
#  network_interface_id = aws_instance.instance.primary_network_interface_id
#}