resource "aws_instance" "instance" {
  ami                         = "ami-002070d43b0a4f171"
  instance_type               = "t2.micro"
  key_name                    = "terra"
  security_groups             = [aws_security_group.security.id]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true


  provisioner "local-exec" {
     command = <<-EOT
        sudo yum update -y
        sudo yum install -y yum-utils
        sudo yum -y install epel-release
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo yum install java-11-openjdk -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
        sudo systemctl enable jenkins
        sudo systemctl start jenkins
        sudo systemctl status jenkins
    EOT
  }

  tags = {
    Name = "instance"
  }
}


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