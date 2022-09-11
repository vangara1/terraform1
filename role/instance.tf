resource "aws_iam_instance_profile" "sandy_profile" {
  name = "sandy_profile"
  role = aws_iam_role.role.name
}


resource "aws_instance" "role" {
  ami           = "ami-002070d43b0a4f171"
  instance_type = "t2.micro"
  iam_instance_profile = "sandy_profile"
  key_id = "key-0e6dd78aa03be5c32"


  tags = {
    Name = "role"
  }
}
