resource "aws_vpc" "vpc_demo" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Roboshop_VPC"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public_Subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Private_Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_demo.id
  tags = {
    Name = "Internet_Gateway_Roboshop"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public_Route"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc_demo.id

  tags = {
    Name = "Private_Route"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
