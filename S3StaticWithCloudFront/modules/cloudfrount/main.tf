# Create CloudFront distribution
resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = var.origin_bucket_domain_name // e.g. mybucket.s3.amazonaws.com
    origin_id   = "S3-${var.origin_bucket_arn}" // e.g. S3-mybucket

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  default_root_object = var.default_root_object

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.origin_bucket_arn}"

    forwarded_values { 
      // Forward cookies to the origin. This is required for S3 static website hosting
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "Production"
  }
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "OAI for S3 Website"
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.cdn.domain_name
}