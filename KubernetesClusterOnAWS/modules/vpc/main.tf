resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block // CIDR block for the VPC
  enable_dns_support   = true  // Enable DNS support
  enable_dns_hostnames = true // Enable DNS hostnames
  
  tags = {
    Name = "eks-vpc"
  }
}

# Create Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets) // Number of public subnets
  vpc_id                  = aws_vpc.main.id // VPC ID
  cidr_block              = var.public_subnets[count.index] // CIDR block for the public subnet
  map_public_ip_on_launch = true // Map public IP on launch
  
  tags = {
    Name = "public-subnet-${count.index}"
  }
}

# Create Private Subnets
resource "aws_subnet" "private" {
  count      = length(var.private_subnets)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets[count.index]
  tags = {
    Name = "private-subnet-${count.index}"
  }
}