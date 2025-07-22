variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "index_document" {
  description = "Index document for the website"
  type        = string
}

variable "error_document" {
  description = "Error document for the website"
  type        = string
}