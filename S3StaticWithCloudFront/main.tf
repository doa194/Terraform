// This Terraform configuration sets up an S3 bucket for a static website and a CloudFront distribution to serve the website over HTTPS. It uses modules to encapsulate the S3 bucket and CloudFront configurations, making the code more modular and reusable.

provider "aws" {
  region = var.aws_region
}

// Define the S3 bucket for the static website
module "s3_website" {
  source         = "./modules/s3"
  bucket_name    = var.bucket_name
  index_document = var.index_document
  error_document = var.error_document
}

// Define the CloudFront distribution
module "cloudfront_distribution" {
  source                     = "./modules/cloudfront"
  origin_bucket_arn          = module.s3_website.bucket_arn
  origin_bucket_domain_name  = module.s3_website.bucket_domain_name
  default_root_object        = var.index_document
}

// Upload website files to the S3 bucket
resource "aws_s3_object" "website_files" {
  for_each = fileset("./website", "*")
  bucket   = module.s3_website.bucket_name
  key      = each.value
  source   = "./website/${each.value}"
  content_type = "text/html"
}