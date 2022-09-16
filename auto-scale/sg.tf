module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "terra-sg-service"
  description = "Security group with custom ports open within VPC"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "tcp"
      description = " ports"
      cidr_blocks = "10.10.0.0/16"
    }
  ]
}