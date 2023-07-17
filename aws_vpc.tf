resource "aws_vpc" "vpc-dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-jenkins"
  }
}

resource "aws_subnet" "vpc-dev-public-subnet-1" {
    vpc_id = aws_vpc.vpc-dev.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "vpc-dev-igw" {
    vpc_id = aws_vpc.vpc-dev.id
}

resource "aws_route_table" "vpc-dev-pubilc-route-table" {
    vpc_id = aws_vpc.vpc-dev.id
}

resource "aws_route" "vpc-dev-pubilc-route" {
    route_table_id = aws_route_table.vpc-dev-pubilc-route-table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-dev-igw.id
}

resource "aws_route_table_association" "vpc-dev-public-route-table-associate" {
    route_table_id = aws_route_table.vpc-dev-pubilc-route-table.id
    subnet_id = aws_subnet.vpc-dev-public-subnet-1.id
}
