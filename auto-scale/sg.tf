#module "vote_service_sg" {
#  source = "terraform-aws-modules/security-group/aws"
#
#  name        = "sg-service"
#  description = "Security group with custom ports open within VPC"
#  vpc_id      = var.vpc_id
#
#  ingress_cidr_blocks      = ["0.0.0.0/0"]
#  ingress_rules            = ["https-443-tcp"]
#  ingress_with_cidr_blocks = [
#    {
#      from_port   = 8080
#      to_port     = 8090
#      protocol    = "tcp"
#      description = "User-service ports"
#      cidr_blocks = "10.10.0.0/16"
#    },
#    {
#      rule        = "postgresql-tcp"
#      cidr_blocks = "0.0.0.0/0"
#    },
#  ]
#}