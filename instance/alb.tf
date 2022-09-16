resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security.id]
  subnets            = [aws_subnet.subnet.id, aws_subnet.subnet-1.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.bucket.bucket
    prefix  = "alb"
    enabled = true
  }

  tags = {
    Environment = "${var.name}production"
  }
}