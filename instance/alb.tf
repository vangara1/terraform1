resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security.id]
  subnets            = [for subnet in aws_subnet.subnet : subnet.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "${var.name}production"
  }
}