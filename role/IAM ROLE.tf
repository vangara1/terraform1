resource "aws_iam_role" "role" {
  name = "sandy_role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    tag-key = "role"
  }
}


resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}


resource "aws_iam_policy" "policy" {
  name        = "sandy_policy"
  path        = "/"
  description = "sandy policy"

  policy = jsonencode({
    "Version" : "2012-10-17", "Statement" : [
      {
        "Action" : "ec2:*", "Effect" : "Allow", "Resource" : "*"
      }, {
        "Effect" : "Allow", "Action" : "ec2:RunInstances", "Resource" : "*"
      }, {
        "Effect" : "Allow", "Action" : "iam:PassRole", "Resource" : "arn:aws:iam::account-id:role/Get-pics"
      }, {
        "Effect" : "Allow", "Action" : "elasticloadbalancing:*", "Resource" : "*"
      }, {
        "Effect" : "Allow", "Action" : "cloudwatch:*", "Resource" : "*"
      }, {
        "Effect" : "Allow", "Action" : "autoscaling:*", "Resource" : "*"
      }, {
        "Effect" : "Allow", "Action" : "iam:CreateServiceLinkedRole", "Resource" : "*", "Condition" : {
          "StringEquals" : {
            "iam:AWSServiceName" : [
              "autoscaling.amazonaws.com", "ec2scheduled.amazonaws.com", "elasticloadbalancing.amazonaws.com",
              "spot.amazonaws.com", "spotfleet.amazonaws.com", "transitgateway.amazonaws.com"
            ]
          }
        }
      }    ]
  })
}

