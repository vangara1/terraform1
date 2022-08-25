ENV             = "dev"
VPC_CIDR        = "190.0.0.0/16"
VPC_CIDR_ADDON  = ["190.128.0.0/25"]
PRIVATE_SUBNETS = ["190.0.0.0/17", "190.0.128.0/17"]
PUBLIC_SUBNETS  = ["190.128.0.0/25", "192.128.0.128/25"]
AZs             = "us-east-1c,us-east-1d"
VPC_DEFAULT_ID  = "vpc-dfvjdsknvs"
DEFAULT_VPC     = " ##default vpc id"




#the below cidr and subnets are to have more than two vpc and subnets
#VPC_CIDR_ADDON = ["190.1.0.0/16]"]
#SUBNETS        = ["190.0.0.0/17", "190.0.128.0/17", "190.1.0.0/17", "190.1.128.0/17"]
