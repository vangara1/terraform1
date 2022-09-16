

terraform {
  backend "s3" {
    bucket = "terra-sree1"
    key    = "raju/terraform.tfstate"
    region = "us-east-1"
  }
}


### ec2 instance creation  app_server-pub and app_server-pvt

resource "aws_instance" "app_server-pvt" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = var.ec2-type
  key_name = var.generated_key_name
  security_groups = [ aws_security_group.allow-sg-pvt.id ]
  subnet_id = aws_subnet.private-sub.id
  associate_public_ip_address = true
  user_data = "user.tpl"
  #  count = 2

  tags = merge(
    local.tags,
    {
      #      Name = "pvt-ec2-${count.index}"
      Name="pvt-ec2"
      name= "devops-raju"
    })
}

resource "aws_instance" "app_server-pub" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = var.ec2-type
  key_name = var.generated_key_name
  security_groups = [ aws_security_group.allow-sg-pub.id ]
  subnet_id = aws_subnet.public-sub.id
  associate_public_ip_address = true
  user_data = "user.tpl"
  #  count = 2

  tags = merge(
    local.tags,
    {
      #    Name = "pub-ec2-${count.index}"
      Name="pub-ec2"
      name= "devops-raju"
    })
}


resource "aws_instance" "app_server-pub" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = var.ec2-type
  key_name = var.generated_key_name
  security_groups = [ aws_security_group.allow-sg-pub.id ]
  subnet_id = aws_subnet.public-sub.id
  associate_public_ip_address = true
  user_data = "user.tpl"
  #  count = 2

  tags = merge(
    local.tags,
    {
      #    Name = "pub-ec2-${count.index}"
      Name="pub-ec2"
      name= "devops-raju"
    })
}

## terraform-key-pair ssh-keygen  generated_key



resource "tls_private_key" "dev_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.generated_key_name
  public_key = tls_private_key.dev_key.public_key_openssh

  provisioner "local-exec" {    # Generate "terraform-key-pair.pem" in current directory
    command = <<-EOT
      echo '${tls_private_key.dev_key.private_key_pem}' > ./'${var.generated_key_name}'.pem
      chmod 400 ./'${var.generated_key_name}'.pem
    EOT
  }

}


#creating elastic ip
resource "aws_eip" "nat-eip" {
  vpc=true
}


### creating vpc my-vpc


resource "aws_vpc" "my_vpc" {
  cidr_block = "172.31.0.0/26"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "my-vpc"
  }
}

#### aws subnets public-sub and private-sub


resource "aws_subnet" "public-sub" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.31.0.0/28"
  availability_zone = "us-east-1a"
  enable_resource_name_dns_a_record_on_launch="true"
  map_public_ip_on_launch = "true"
  tags = merge(
    local.tags,
    {
      Name = "my_vpc-pub-sub"
    })
}


resource "aws_subnet" "private-sub" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "172.31.0.32/28"
  availability_zone = "us-east-1b"
  enable_resource_name_dns_a_record_on_launch="true"
  tags = merge(
    local.tags,
    {
      Name = "my_vpc-pvt-sub"
    })
}


##### aws internet gate way

resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = merge(
    local.tags,{
      Name = "my-vpc-igw"
    })
}


### aws nat gateway

resource "aws_nat_gateway" "dev-nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id = aws_subnet.public-sub.id
  tags={
    Name="Nat Gateway"
  }
  depends_on = [aws_internet_gateway.my_vpc_igw]
}



##### aws internet gateway attachment not working in this version



#resource "aws_internet_gateway_attachment" "igw-attach" {
#  internet_gateway_id=aws_internet_gateway.my_vpc_igw.id
#  vpc_id=aws_vpc.my_vpc.id
#}

###################### aws route tables and association

resource "aws_route_table" "my-pvt-rt" {
  vpc_id =aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev-nat.id
  }
  tags =merge(
    local.tags,
    {
      Name="pvt-RT"
    })
}

resource "aws_route_table_association" "sub-pub" {
  subnet_id =aws_subnet.public-sub.id
  route_table_id = aws_route_table.my-pub-rt.id
}
resource "aws_route_table_association" "sub-pvt" {
  subnet_id =aws_subnet.private-sub.id
  route_table_id = aws_route_table.my-pvt-rt.id
}
resource "aws_route_table" "my-pub-rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_vpc_igw.id
  }

  tags = merge(
    local.tags,
    {
      Name = "pub-rt"
    })
}



############################## aws security groups


resource "aws_security_group" "allow-sg-pub" {
  name        = "allow-sg-pub"
  description = "Allow SSH inbound connections"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allowing all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_sg-pub"
  }

}

resource "aws_security_group" "allow-sg-pvt" {
  name        = "allow-sg-pvt"
  description = "Allow SSH inbound connections"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allowing with in vpc "
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.0.0/26"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_sg-pvt"
  }

}

###################################### aws ALB load balancers terraform code  security groups public and private vpc attachments



resource "aws_security_group" "alb" {
  name        = "terraform_alb_security_group"
  description = "Terraform load balancer security group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/26"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/26"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}


####################### aws ALB creation



resource "aws_alb" "alb" {
  name            = "terraform-alb"
  security_groups = [aws_security_group.alb.id]
  subnets         = [aws_subnet.public-sub.id,aws_subnet.private-sub.id]
  tags = {
    Name = "terraform-alb"
  }
}



########### outputs in terraform



output "vpc-id" {
  value = aws_vpc.my_vpc.id
}

output "ssh_key" {
  description = "ssh key generated by terraform"
  sensitive = true
  value       = tls_private_key.dev_key.private_key_pem
}



#################### variables in terraform


variable "ec2-type" {
  description = "Ec2 Instance Type"
  type=string
  default = "t2.micro"
}


variable "generated_key_name" {
  type        = string
  default     = "terraform-key-pair"
  description = "Key-pair generated by Terraform"
}

############# local variable in aws terraform


locals {
  tags= {
    env="dev"
    project = "aws-vpc"
  }
}







resource "aws_subnet" "private-subnet" {
  depends_on        = [aws_vpc_ipv4_cidr_block_association.addon]
  count             = length(var.PRIVATE_SUBNETS)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.PRIVATE_SUBNETS, count.index)
  availability_zone = element(var.AZS, count.index)

  tags = {
    Name = "privatesubnet-${count.index}"
  }
}

resource "aws_subnet" "public-subnet" {
  depends_on        = [aws_vpc_ipv4_cidr_block_association.addon]
  count             = length(var.PUBLIC_SUBNETS)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.PUBLIC_SUBNETS, count.index)
  availability_zone = element(var.AZS, count.index)

  tags = {
    Name = "public-subnet-${count.index}"
  }
}


resource "aws_route_table_association" "pvt-association" {
  count          = length(aws_subnet.private-subnet.*.id)
  subnet_id      = element(aws_subnet.private-subnet.*.id, count.index)
  route_table_id = aws_route_table.pvt-route.id
}
resource "aws_route_table_association" "public-association" {
  count          = length(aws_subnet.public-subnet.*.id)
  subnet_id      = element(aws_subnet.public-subnet.*.id, count.index)
  route_table_id = aws_route_table.pub-route.id
}


#
#resource "aws_vpc" "main" {
#  cidr_block           = var.VPC_CIDR
#  enable_dns_hostnames = true
#  enable_dns_support   = true
#
#  tags = {
#    Name = var.ENV
#  }
#}

#resource "aws_vpc_ipv4_cidr_block_association" "addon" {
#  count      = length(var.VPC_CIDR_ADDON)
#  vpc_id     = aws_vpc.main.id
#  cidr_block = element(var.VPC_CIDR_ADDON, count.index )
#}


ENV                    = "dev"
VPC_CIDR               = "170.1.0.0/16"
VPC_CIDR_ADDON         = ["170.255.0.0/24"]
PRIVATE_SUBNETS        = ["170.1.0.0/17", "170.1.128.0/17"]
PUBLIC_SUBNETS         = ["170.255.0.0/25", "170.255.0.128/25"]
AZS                    = ["us-east-1c", "us-east-1d"]
VPC_DEFAULT_ID         = "vpc-078a65ec215c92579"
DEFAULT_VPC_CIDR       = "172.31.0.0/16"
INTERNAL_HOSTEDZONE_ID = "Z0659015OB7PKCI93ZBC"

variable "ENV" {}
variable "VPC_CIDR" {}
variable "VPC_CIDR_ADDON" {}
variable "PRIVATE_SUBNETS" {}
variable "PUBLIC_SUBNETS" {}
variable "AZS" {}
variable "VPC_DEFAULT_ID" {}
variable "DEFAULT_VPC_CIDR" {}
variable "INTERNAL_HOSTEDZONE_ID" {}


resource "aws_route_table" "pvt-route" {
  vpc_id = aws_vpc.main.id
  route {
      cidr_block                 = var.DEFAULT_VPC_CIDR
      vpc_peering_connection_id  = aws_vpc_peering_connection.peer.id
    }
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "private-route"
  }
}

resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.main.id
  route   {
    cidr_block                 = var.DEFAULT_VPC_CIDR
    vpc_peering_connection_id  = aws_vpc_peering_connection.peer.id
  }
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }

  tags = {
    Name = "public-route"
  }
}


resource "aws_route" "route-from-default-vpc" {
  count                     = length(local.association-list)
  route_table_id            = tomap(element(local.association-list, count.index))["route_table"]
  destination_cidr_block    = tomap(element(local.association-list, count.index))["cidr"]
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id

}





output "VPC_ID" {
  value = aws_vpc.main.id
}

output "DEFAULT_VPC_ID" {
  value = var.VPC_DEFAULT_ID
}

output "PRIVATE_SUBNET_IDS" {
  value = aws_subnet.private-subnet.*.id
}

output "PUBLIC_SUBNET_IDS" {
  value = aws_subnet.public-subnet.*.id
}

output "PRIVATE_SUBNET_CIDR" {
  value = aws_subnet.private-subnet.*.cidr_block
}

output "PUBLIC_SUBNET_CIDR" {
  value = aws_subnet.public-subnet.*.cidr_block
}

output "DEFAULT_VPC_CIDR" {
  value = var.DEFAULT_VPC_CIDR
}

output "INTERNAL_HOSTEDZONE_ID" {
  value = var.INTERNAL_HOSTEDZONE_ID
}
 output "ALL_VPC_CIDR" {
   value = local.ALL_VPC_CIDR
 }


 resource "aws_eip" "ngw-eip" {
   vpc = true
   tags = {
     Name = "${var.ENV}-ngw-eip"
   }
 }

 resource "aws_nat_gateway" "ngw" {
   allocation_id = aws_eip.ngw-eip.id
   subnet_id     = aws_subnet.public-subnet.*.id[0]

   tags = {
     Name = "${var.ENV}-ngw"
   }
 }


 locals {
   VPC_CIDR     = split(",", var.VPC_CIDR)
   ALL_VPC_CIDR = concat(local.VPC_CIDR, var.VPC_CIDR_ADDON)

 }
 #
 #output "ALL_VPC_CIDR" {
 #  value = [for s in local.ALL_VPC_CIDR : "CIDR = ${s}"]
 #}

 locals {
   association-list = flatten([
   for cidr in local.ALL_VPC_CIDR : [
   for route_table in tolist(data.aws_route_tables.default-vpc-routes.ids) : {
     cidr        = cidr
     route_table = route_table
   }
   ]
   ])
 }

 #output "sample" {
 #  value = tomap(element(local.association-list,0))["cidr"]
 #}


 resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.main.id

   tags = {
     Name = "${var.ENV}-IGW"
   }
 }


 data "aws_route_tables" "default-vpc-routes" {
   vpc_id = var.VPC_DEFAULT_ID
 }

 #output "aws_route_table" {
 #  value = data.aws_route_table.default-vpc-routes
 #}