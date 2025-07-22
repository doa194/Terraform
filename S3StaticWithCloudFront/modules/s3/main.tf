# Create the S3 bucket
resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name

  }
  
  # Configure website settings
  resource "aws_s3_bucket_website_configuration" "website_config" {
    bucket = aws_s3_bucket.website.id
  
    index_document {
      suffix = var.index_document
    }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.website.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Public access block
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.website.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}

# Bucket policy for public access
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = ["s3:GetObject"]
        Resource = ["${aws_s3_bucket.website.arn}/*"]
      }
    ]
  })
}