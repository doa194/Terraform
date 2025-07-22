variable "primary_region" {
  default = "us-east-1"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "azs" {
  default = ["us-east-1a", "us-east-1b"]
}
variable "db_name" {
  default = "productiondb"
}
variable "db_username" {
  default = "admin" // Default username for the RDS instance. This should be changed to a secure value in production and should not be hardcoded in the code.
}
variable "db_password" {
  default = "password" // Default password for the RDS instance. This should be changed to a secure value in production and should not be hardcoded in the code.
}