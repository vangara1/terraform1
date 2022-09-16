module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_id

  azs            = [var.az]
  public_subnets = [var.subnet_cidr]

  tags = {
    Name = "${var.name}"
  }
}