data "aws_availability_zones" "available" {}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "Y-R VPC"
    Project = "TeamE"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "Y-R IGW"
    Project = "TeamE"
  }

  depends_on = [aws_vpc.main]
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name    = "Y-R Public Subnet ${count.index + 1}"
    Project = "TeamE"
  }

  depends_on = [aws_vpc.main]
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "Y-R Public Route Table"
    Project = "TeamE"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_subnet" {
  count = length(aws_subnet.public)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id

  depends_on = [aws_route_table.public, aws_subnet.public]
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index + 2)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name    = "Y-R Private Subnet ${count.index + 1}"
    Project = "TeamE"
  }

  depends_on = [aws_vpc.main]
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "Y-R Private Route Table"
    Project = "TeamE"
  }

  depends_on = [aws_vpc.main]
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_subnet" {
  count = length(aws_subnet.private)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id

  depends_on = [aws_route_table.private, aws_subnet.private]
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name    = "Y-R NAT EIP"
    Project = "TeamE"
  }
}

# NAT Gateway in the first Public Subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name    = "Y-R NAT Gateway"
    Project = "TeamE"
  }
  depends_on = [
    aws_internet_gateway.igw,
    aws_subnet.public,
    aws_eip.nat
  ]
}

# Route for Private Subnet to use NAT Gateway
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id

  depends_on = [
    aws_nat_gateway.nat,
    aws_eip.nat
  ]
}
