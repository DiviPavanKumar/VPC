resource "aws_vpc" "vpc_demo" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPN_Demo_Testing"
  }
}

resource "aws_subnet" "vpc_demo_subnets" {

  for_each = { for subnet in var.subnet_configs : subnet.name => subnet }

  vpc_id            = aws_vpc.vpc_demo.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = each.key
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_demo.id

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc_demo.id

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_demo.id
  tags = {
    Name = "IGW"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "subnet_associations" {
  for_each = { for subnet in var.subnet_configs : subnet.name => subnet }

  subnet_id = aws_subnet.vpc_demo_subnets[each.key].id

  route_table_id = each.value.name == "Web" ? aws_route_table.public.id : aws_route_table.private.id
}



