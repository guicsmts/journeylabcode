// main.tf
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_subnet" "eks_subnet_public" {
  count = length(var.subnet_cidrs_public)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = element(var.subnet_cidrs_public, count.index)
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "eks-subnet-public-${count.index}"
  }
}

resource "aws_subnet" "eks_subnet_private" {
  count = length(var.subnet_cidrs_private)
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = element(var.subnet_cidrs_private, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "eks-subnet-private-${count.index}"
  }
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "eks-igw"
  }
}

resource "aws_route_table" "eks_route_table_public" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = {
    Name = "eks-route-table-public"
  }
}

resource "aws_route_table_association" "eks_subnet_public_assoc" {
  count          = length(var.subnet_cidrs_public)
  subnet_id      = aws_subnet.eks_subnet_public[count.index].id
  route_table_id = aws_route_table.eks_route_table_public.id
}

resource "aws_nat_gateway" "eks_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.eks_subnet_public[0].id

  tags = {
    Name = "eks-nat-gateway"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_route_table" "eks_route_table_private" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks_nat_gateway.id
  }

  tags = {
    Name = "eks-route-table-private"
  }
}

resource "aws_route_table_association" "eks_subnet_private_assoc" {
  count          = length(var.subnet_cidrs_private)
  subnet_id      = aws_subnet.eks_subnet_private[count.index].id
  route_table_id = aws_route_table.eks_route_table_private.id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.28.0"

  cluster_name    = "eks-cluster"
  cluster_version = "1.27"
  vpc_id          = aws_vpc.eks_vpc.id
  subnet_ids      = concat(aws_subnet.eks_subnet_public[*].id, aws_subnet.eks_subnet_private[*].id)

  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1

      instance_type = "t3.micro"
    }
  }

  tags = {
    Name = "eks-cluster"
  }
}
