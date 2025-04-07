# -------------------------------------
# Create a Virtual Private Cloud (VPC)
# -------------------------------------
resource "aws_vpc" "vpc_demo" {
  cidr_block = "10.0.0.0/16"  # IP range for the entire VPC (65,536 addresses)

  tags = {
    Name = "Roboshop_VPC"     # Tag for easy identification in the AWS Console
  }
}

# -------------------------------------
# Create a Public Subnet
# -------------------------------------
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc_demo.id    # Associate subnet with the VPC
  cidr_block = "10.0.1.0/24"          # 256 IPs (usable ~251)

  tags = {
    Name = "Public_Subnet"            # Tag for identification
  }
}

# -------------------------------------
# Create a Private Subnet
# -------------------------------------
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = "10.0.2.0/24"          # Another 256 IP subnet for internal use

  tags = {
    Name = "Private_Subnet"
  }
}

# -------------------------------------
# Create an Internet Gateway (IGW)
# Allows internet access for public subnets
# -------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_demo.id        # Attach IGW to the VPC

  tags = {
    Name = "Internet_Gateway_Roboshop"
  }
}

# ---------------------------------------------------------
# Create a Route Table for the Public Subnet
# Includes a route to the Internet Gateway
# ---------------------------------------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_demo.id

  # Default route for outbound internet traffic
  route {
    cidr_block = "0.0.0.0/0"                  # Route all traffic
    gateway_id = aws_internet_gateway.igw.id  # Send through IGW
  }

  tags = {
    Name = "Public_Route"
  }
}

# ---------------------------------------------------------
# Create a Route Table for the Private Subnet
# No internet access is configured here (no default route)
# ---------------------------------------------------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc_demo.id

  tags = {
    Name = "Private_Route"
  }
}

# ---------------------------------------------------------
# Associate the Public Subnet with the Public Route Table
# Makes the subnet publicly accessible
# ---------------------------------------------------------
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ---------------------------------------------------------
# Associate the Private Subnet with the Private Route Table
# Keeps the subnet internal with no internet access
# ---------------------------------------------------------
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
