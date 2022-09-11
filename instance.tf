resource "aws_iam_instance_profile" "sandy_profile" {
  name = "sandy_profile"
  role = aws_iam_role.role.name
}


data "aws_launch_template" "centos" {
  name = "centos"
  id = "lt-06a0f28ee3faf1441"
}

