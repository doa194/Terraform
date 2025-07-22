resource "aws_subnet" "public" {
  count = var.create_subnets ? length(var.public_subnet_cidrs) : 0
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count = var.create_subnets ? length(var.private_subnet_cidrs) : 0
  vpc_id     = var.vpc_id
  cidr_block = var.private_subnet_cidrs[count.index]
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}