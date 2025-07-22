resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.name}-vpc"
  }
}


# This module creates public subnets in each availability zone specified in the variable

resource "aws_subnet" "public" {
  count             = length(var.azs) // Number of availability zones
  vpc_id            = aws_vpc.this.id // Reference the VPC created above
  cidr_block        = cidrsubnet(var.cidr_block, 4, count.index) // Calculate the CIDR block for each subnet
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public-${var.azs[count.index]}"
  }
}