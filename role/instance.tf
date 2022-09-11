resource "aws_iam_instance_profile" "sandy_profile" {
  name = "sandy_profile"
  role = aws_iam_role.role.name
}


resource "aws_instance" "role" {
  ami                  = "ami-002070d43b0a4f171"
  instance_type        = "t2.micro"
  iam_instance_profile = "sandy_profile"


  tags = {
    Name = "role"
  }
}
resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
}

resource "local_file" "file" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "file"
}