provider "aws" {
  region = var.region
}

resource "aws_vpc" "knab_vpc" {
  cidr_block = var.vpc_cidr
  tags       = merge(var.tags, { Name = "knab-lab-private-vpc" })
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.knab_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "${var.region}a"
  tags              = merge(var.tags, { Name = "knab-lab-private-subnet" })
}
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.knab_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "${var.region}a"
  tags              = merge(var.tags, { Name = "knab-lab-public-subnet" })
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = merge(var.tags, { Name = "knab-lab-nat-eip" })
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = merge(var.tags, { Name = "knab-lab-nat-gateway" })
}

resource "aws_internet_gateway" "knab_lab_igw" {
  vpc_id = aws_vpc.knab_vpc.id
  tags = merge(var.tags, { Name = "knab-lab-igw" })
}

resource "aws_ec2_transit_gateway_vpc_attachment" "knab_vpc_attachment" {
  transit_gateway_id = data.aws_ec2_transit_gateway.knab-lab-transit-gateway.id
  vpc_id             = aws_vpc.knab_vpc.id
  subnet_ids         = [aws_subnet.private_subnet.id]
  tags               = merge(var.tags, { Name = "knab-lab-tgw-attachment" })
}

resource "aws_route_table" "knab_lab_nat_rt" {
  vpc_id = aws_vpc.knab_vpc.id
  tags = merge(var.tags, { Name = "knab-lab-nat-rt" })
}

resource "aws_route_table_association" "knab_lab_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.knab_lab_nat_rt.id
}


resource "aws_route" "knab_vpc_to_igw" {
  route_table_id         = aws_vpc.knab_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.knab_lab_igw.id
}

resource "aws_route" "knab_vpc_to_nat" {
  route_table_id         = aws_route_table.knab_lab_nat_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}
resource "aws_route" "knab_vpc_to_tgw" {
  route_table_id         = aws_route_table.knab_lab_nat_rt.id
  destination_cidr_block = "172.31.0.0/24"
  transit_gateway_id     = data.aws_ec2_transit_gateway.knab-lab-transit-gateway.id
}