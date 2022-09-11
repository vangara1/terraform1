resource "aws_iam_role" "tes-role" {
  name = "test-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "ec2:*",
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "elasticloadbalancing:*",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "cloudwatch:*",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "autoscaling:*",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "iam:CreateServiceLinkedRole",
        "Resource": "*",
        "Condition": {
          "StringEquals": {
            "iam:AWSServiceName": [
              "autoscaling.amazonaws.com",
              "ec2scheduled.amazonaws.com",
              "elasticloadbalancing.amazonaws.com",
              "spot.amazonaws.com",
              "spotfleet.amazonaws.com",
              "transitgateway.amazonaws.com"
            ]
          }
        }
      }
    ]
  })

  tags = {
    tag-key = "sandy-admin"
  }
}
