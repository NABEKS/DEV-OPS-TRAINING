# Configure the VPC
resource "aws_vpc" "Naa-vpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Naa-vpc1"
  }
}


# Configure the Public Subnet 1
resource "aws_subnet" "Pub-Subnet1" {
  vpc_id     = aws_vpc.Naa-vpc1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Pub-Subnet1"
  }
}

# Configure the Public Subnet 2
resource "aws_subnet" "Pub-Subnet2" {
  vpc_id     = aws_vpc.Naa-vpc1.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Pub-Subnet2"
  }
}

# Configure the Private Subnet 1
resource "aws_subnet" "Priv-Subnet1" {
  vpc_id     = aws_vpc.Naa-vpc1.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Priv-Subnet1"
  }
}

# Configure the Private Subnet 2
resource "aws_subnet" "Priv-Subnet2" {
  vpc_id     = aws_vpc.Naa-vpc1.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Priv-Subnet2"
  }
}

# Configure the Public Route Table
resource "aws_route_table" "Naa-Public-RT" {
  vpc_id = aws_vpc.Naa-vpc1.id

  tags = {
    Name = "Naa-Public-RT"
  }
}

# Configure the Private Route Table
resource "aws_route_table" "Naa-Private-RT" {
  vpc_id = aws_vpc.Naa-vpc1.id

  tags = {
    Name = "Naa-Private-RT"
  }
}

# Route Association Public  
resource "aws_route_table_association" "Naa-Public-RT-Association-1" {
  subnet_id      = aws_subnet.Pub-Subnet1.id
  route_table_id = aws_route_table.Naa-Public-RT.id
}

resource "aws_route_table_association" "Naa-Public-RT-Association-2" {
  subnet_id      = aws_subnet.Pub-Subnet2.id
  route_table_id = aws_route_table.Naa-Public-RT.id
}


# Route Association Private
resource "aws_route_table_association" "Naa-Private-RT-Association-1" {
  subnet_id      = aws_subnet.Priv-Subnet1.id
  route_table_id = aws_route_table.Naa-Private-RT.id
}


resource "aws_route_table_association" "Naa-Private-RT-Association-2" {
  subnet_id      = aws_subnet.Priv-Subnet2.id
  route_table_id = aws_route_table.Naa-Private-RT.id
}

# Internet Gateway
resource "aws_internet_gateway" "Naa-IGW-1" {
  vpc_id = aws_vpc.Naa-vpc1.id

  tags = {
    Name = "Naa-IGW-1"
  }
}

# Internet Gateway Route
resource "aws_route" "Naa-IGW-Route-1" {
  route_table_id            = aws_route_table.Naa-Public-RT.id
  gateway_id                = aws_internet_gateway.Naa-IGW-1.id
  destination_cidr_block    = "0.0.0.0/0"
  } 

