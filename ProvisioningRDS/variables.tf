// This file defines the variables used in the Terraform configuration for AWS RDS and VPC setup.

variable "aws_region"{
    description = "AWS region to deploy resources"
    type        = string
    default     = "us-east-1"
}

variable "vpc_cdir_block" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "enable_dns"{
    description = "Enable DNS support in the VPC"
    type        = bool
    default     = true
}

variable "public_subnet_cidrs" {
    description = "List of CIDR blocks for public subnets"
    type        = list(string)
    default     = ["10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
    description = "List of CIDR blocks for private subnets"
    type        = list(string)
    default     = ["10.0.2.0/24"]
}

variable "create_subnets" {
    description = "Flag to create public and private subnets"
    type        = bool
    default     = true
}

variable "db_instance_class" {
    description = "Instance class for the RDS instance"
    type        = string
    default     = "db.t3.micro"
}

variable "db_engine" {
    description = "Database engine for the RDS instance"
    type        = string
    default     = "mysql"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}