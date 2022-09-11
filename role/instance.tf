resource "aws_iam_instance_profile" "sandy_profile" {
  name = "sandy_profile"
  role = aws_iam_role.role.name
}


resource "aws_instance" "role" {
  ami                  = "ami-002070d43b0a4f171"
  instance_type        = "t2.micro"
  iam_instance_profile = "sandy_profile"
  key_name             = "terra"


  tags = {
    Name = "role"
  }
}

resource "aws_key_pair" "terra" {
  key_name   = "terra"
  key_id     = "key-0e6dd78aa03be5c32"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCLySsXaB2TJzq5NrShfFkYh6kPv6A75jX7TkFPilH5OUGo3X12jRs483HE2UbDy4MPqld3hK0bH8kaIloYG4LgU8FR9D+Hc0JbHI2bq/FoPFSODu+VISBnwu5kEiWkdoTEMMyZPqhItluERfE1x9TvBqZ4Uk54heQBLE6BC5RQka08VKZwxV9VIBaZliB58QMBk2M7pOrOB4EWPs5x3Nxo2GUYajQX07YFk234fQyQAWcuBZGA8gHVMiY9Y7hS8ppPKF2vT8KvioyudoCb2AJQz1ItzJBUqUZXDz0oEppbYkxPZxJyQ01zMQumRpQPbCRdT0UrLn6KZXpzfBu/GwN7 imported-openssh-key"
}