resource "aws_instance" "instance" {
  ami           = "ami-002070d43b0a4f171"
  instance_type = "t2.micro"

tags = {
  Name = "HelloWorld"
}
}
