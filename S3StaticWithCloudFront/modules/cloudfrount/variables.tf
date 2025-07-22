variable "origin_bucket_arn" {
  description = "ARN of the S3 bucket"
  type        = string
}

variable "origin_bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  type        = string
}

variable "default_root_object" {
  description = "Default root object for CloudFront"
  type        = string
}