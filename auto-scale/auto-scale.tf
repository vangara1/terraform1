#
#resource "aws_lb_target_group" "hashicups" {
#  name     = "learn-asg-hashicups"
#  port     = 80
#  protocol = "HTTP"
#  vpc_id   = module.vpc.vpc_id
#}
##
#resource "aws_launch_configuration" "lunch-terra" {
#  name_prefix     = "lunch-terra"
#  image_id        = var.ami
#  instance_type   = var.instance
#  security_groups = var.
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}
#
#resource "aws_autoscaling_group" "auto" {
#  min_size             = 1
#  max_size             = 3
#  desired_capacity     = 1
#  launch_configuration = aws_launch_configuration.lunch-terra.name
#  vpc_zone_identifier  = module.vpc.public_subnets
#}

#resource "aws_lb" "terramino" {
#  name               = "learn-asg-terramino-lb"
#  internal           = false
#  load_balancer_type = "application"
#  security_groups    = [aws_security_group.terramino_lb.id]
#  subnets            = module.vpc.public_subnets
#}
#
#resource "aws_lb_listener" "terramino" {
#  load_balancer_arn = aws_lb.terramino.arn
#  port              = "80"
#  protocol          = "HTTP"
#
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.terramino.arn
#  }
#}
#
#resource "aws_lb_target_group" "terramino" {
#  name     = "learn-asg-terramino"
#  port     = 80
#  protocol = "HTTP"
#  vpc_id   = module.vpc.vpc_id
#}
#
#resource "aws_autoscaling_attachment" "terramino" {
#  autoscaling_group_name = aws_autoscaling_group.terramino.id
#  alb_target_group_arn   = aws_lb_target_group.terramino.arn
#}
#
#resource "aws_security_group" "terramino_instance" {
#  name = "learn-asg-terramino-instance"
#  ingress {
#    from_port       = 80
#    to_port         = 80
#    protocol        = "tcp"
#    security_groups = [aws_security_group.terramino_lb.id]
#  }
#
#  egress {
#    from_port       = 0
#    to_port         = 0
#    protocol        = "-1"
#    security_groups = [aws_security_group.terramino_lb.id]
#  }
#
#  vpc_id = module.vpc.vpc_id
#}
#
#resource "aws_security_group" "terramino_lb" {
#  name = "learn-asg-terramino-lb"
#  ingress {
#    from_port   = 80
#    to_port     = 80
#    protocol    = "tcp"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  vpc_id = module.vpc.vpc_id
#}
#
