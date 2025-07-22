variable "name" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "db_name" {
  type = string
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type = string
}
variable "security_group_id" {
  type = string
}