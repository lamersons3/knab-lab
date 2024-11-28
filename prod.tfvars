region              = "eu-central-1"
vpc_cidr            = "10.241.0.0/16"
private_subnet_cidr = "10.241.100.0/24"
public_subnet_cidr  = "10.241.101.0/24"
ec2_instance_type   = "t2.micro"
ec2_private_ip      = "10.241.100.4"
tags = {
  Project = "knab-lab"
  Owner   = "mikez"
}   