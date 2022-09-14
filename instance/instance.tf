resource "aws_instance" "instance" {
  ami                         = "ami-002070d43b0a4f171"
  instance_type               = "t2.micro"
  key_name                    = "terra"
  security_groups             = [aws_security_group.security.id]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true
  #  wait_for_fulfillment = true
  tags                        = {
    Name = "instance"
  }
}

#
#resource "aws_instance" "app_server-pub" {
#  ami           = "ami-05fa00d4c63e32376"
#  instance_type = var.ec2-type
#  key_name = var.generated_key_name
#  security_groups = [ aws_security_group.allow-sg-pub.id ]
#  subnet_id = aws_subnet.public-sub.id
#  associate_public_ip_address = true
#  user_data = "user.tpl"
#  #  count = 2
#
#  tags = merge(
#    local.tags,
#    {
#      #    Name = "pub-ec2-${count.index}"
#      Name="pub-ec2"
#      name= "devops-raju"
#    })
#}


#      "sudo yum install -y jenkins java-11-openjdk-devel", "sudo yum -y install wget",
#      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
#      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key", "sudo yum upgrade -y",
#      "sudo yum install jenkins -y", "sudo systemctl start jenkins",
#
#
#resource "aws_key_pair" "key" {
#  key_name   = "key"
#  public_key = tls_private_key.rsa.public_key_openssh
#}
#resource "tls_private_key" "rsa" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}
#resource "local_file" "key" {
#  content  = tls_private_key.rsa.private_key_pem
#  filename = "key"
#}