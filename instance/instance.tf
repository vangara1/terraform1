resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance
  #  key_name                    = "key"
  vpc_security_group_ids      = [aws_security_group.security.id]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true


  user_data = file("install_jenkins.sh")

  tags = {
    Name = "${var.name}-instance"
  }
}


