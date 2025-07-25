output "bucket_name" {
  value = aws_s3_bucket.website.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.website.arn
}

output "bucket_domain_name" {
  value = aws_s3_bucket.website.website_endpoint
}