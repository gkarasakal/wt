data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags                 = {
    Name        = "Gokhan ${var.env} VPC",
    Project     = "WT",
    Environment = var.env
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags   = {
    Name        = "Gokhan Internet Gateway"
    Environment = var.env
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name        = "Gokhan Public Route Table"
    Project     = "WT"
    Environment = var.env
  }
}

resource "aws_main_route_table_association" "main_route_table" {
  vpc_id = aws_vpc.vpc.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Gokhan Private Route Table"
    Project     = "WT"
    Environment = var.env
  }
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_cidr_blocks)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  cidr_block        = var.public_cidr_blocks[count.index]
  vpc_id            = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  tags              = {
    Name        = "Gokhan Public Subnet ${(count.index +1)}"
    Project     = "WT"
    Environment = var.env
    "kubernetes.io/cluster/Gokhan-EKS-Cluster-${local.env}" = "shared"
    "kubernetes.io/role/alb-ingress" = "1"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_cidr_blocks)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  cidr_block        = var.private_cidr_blocks[count.index]
  vpc_id            = aws_vpc.vpc.id
  tags              = {
    Name        = "Gokhan Private Subnet ${(count.index +1)}"
    Project     = "WT"
    Environment = var.env
    "kubernetes.io/cluster/Gokhan-EKS-Cluster-${local.env}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_route_table_association" "public_route_association" {
  count          = length(var.public_cidr_blocks)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "private_route_association" {
  count          = length(var.private_cidr_blocks)
  subnet_id      = element(aws_subnet.private_subnet.*.id,count.index)
  route_table_id = aws_route_table.private_route_table.id
}
