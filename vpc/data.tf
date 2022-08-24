data "aws_route_tables" "default-vpc-routes" {
  vpc_id =var.VPC_DEFAULT_ID
}

output "aws_route_tables" {
  value = data.aws_route_tables.default-vpc-routes
}