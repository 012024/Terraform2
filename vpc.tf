resource "aws_vpc" "Naj_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "Naj_vpc"
  }
}

# public subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.Naj_vpc.id
  cidr_block = var.public_subnet_cidr_1

  tags = {
    Name = "public_ subnet_1"
  }
}

# public subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.Naj_vpc.id
  cidr_block = var.public_subnet_cidr_2

  tags = {
    Name = "public_ subnet_2"
  }
}
# private subnet
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.Naj_vpc.id
  cidr_block = var.private_subnet_cidr_1

  tags = {
    Name = "private_subnet_1"
  }
}

# private subnet
resource "aws_subnet" "private_subnet_cidr_2" {
  vpc_id     = aws_vpc.Naj_vpc.id
  cidr_block = var.private_subnet_cidr_2

  tags = {
    Name = "private_subnet_cidr_2"
  }
}
# aws public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.Naj_vpc.id

  tags = {
    Name = "public_route_table"
  }
}

# aws private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.Naj_vpc.id

  tags = {
    Name = "private_route_table"
  }
}

# aws private route association
resource "aws_route_table_association" "private_aws_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

# aws private route association
resource "aws_route_table_association" "private_aws_route_table_association1" {
  subnet_id      = aws_subnet.private_subnet_cidr_2.id
  route_table_id = aws_route_table.private_route_table.id
}

# aws public route association
resource "aws_route_table_association" "public_aws_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

# aws public route association
resource "aws_route_table_association" "public_aws_route_table_association1" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# aws IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Naj_vpc.id

  tags = {
    Name = "igw"
  }
}

# aws route for igw and public route 
resource "aws_route" "public_internet_igw_route" {
  route_table_id            = aws_route_table.public_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw.id   
}

# Create Elastic IP Address

resource "aws_eip" "Naj_IP" {
  tags = {
    Name = "Naj_IP"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "Prod_nat_gateway" {
  allocation_id = aws_eip.Naj_IP.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "Prod_nat_gateway"
  }
}

# NAT Associate with Priv route
resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private_route_table.id
  gateway_id = aws_nat_gateway.Prod_nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}