resource "aws_vpc" "main"{
    cidr_block = var.vpc_cidr_block
    enable_dns_support = var.enable_dns
    enable_dns_hostnames = var.enable_dns
    tags = {
        Name = "main-vpc"
    }
}

output "vpc_id" {
    value = aws_vpc.main.id
}