#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
# VPC
resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.test-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-1"
  }
}

# Private Subnet
resource "aws_subnet" "private-1" {
  vpc_id            = aws_vpc.test-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "private-1"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id            = aws_vpc.test-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "private-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "itg" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "itg-1"
  }
}

# Route Table (public)
resource "aws_route_table" "route-table-public" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "route-table-public"
  }
}

resource "aws_route" "route-public" {
  gateway_id             = aws_internet_gateway.itg.id
  route_table_id         = aws_route_table.route-table-public.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "route_table_association_public" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.route-table-public.id
}

# Route Table (private)
resource "aws_route_table" "route-table-private" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
    Name = "route-table-private"
  }
}

resource "aws_route_table_association" "route_table_association_private" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.route-table-private.id
}

# S3 and Endpoint
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.test-vpc.id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  route_table_id  = aws_route_table.route-table-private.id
}
