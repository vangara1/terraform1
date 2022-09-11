
resource "aws_instance" "foo" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}
#resource "aws_spot_instance_request" "cheap_worker" {
#  ami           = "ami-1234"
#  spot_price    = "0.03"
#  instance_type = "c4.xlarge"
#
#  tags = {
#    Name = "CheapWorker"
#  }
#}