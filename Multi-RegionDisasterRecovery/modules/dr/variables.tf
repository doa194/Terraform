variable "dr_region" {
  default = "us-west-2"
}
variable "vpc_cidr" {
  default = "10.1.0.0/16"
}
variable "azs" {
  default = ["us-west-2a", "us-west-2b"]
}
variable "primary_snapshot_arn" {
  description = "The ARN of the primary region's DB snapshot. Obtain this from primary/outputs.tf"
}