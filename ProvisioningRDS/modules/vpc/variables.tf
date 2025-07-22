variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns" {
  description = "Enable DNS support in the VPC"
  type        = bool
}