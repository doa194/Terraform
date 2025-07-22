# Output the S3 bucket name
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3_website.bucket_name
}

# Output the CloudFront URL
output "cloudfront_url" {
  description = "URL of the CloudFront distribution"
  value       = module.cloudfront_distribution.cloudfront_url
}