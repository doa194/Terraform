# AWS Region
variable "aws_region" {
  description = "AWS region for resource creation"
  type        = string
  default     = "us-west-2"
}

# S3 Bucket Configuration
variable "bucket_name" {
  description = "Name of the S3 bucket for static website hosting"
  type        = string
}

variable "index_document" {
  description = "Index document for the website"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Error document for the website"
  type        = string
  default     = "error.html"
}