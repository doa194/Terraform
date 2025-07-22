variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "Name of Lambda function"
  type        = string
  default     = "S3EventProcessor"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "event-driven-lambda-s3-bucket-demo"
}