resource "aws_iam_instance_profile" "sandy_profile" {
  name = "sandy_profile"
  role = aws_iam_role.role.name
}

