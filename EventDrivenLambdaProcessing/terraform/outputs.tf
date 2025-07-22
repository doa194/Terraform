output "s3_bucket_name" {
  description = "S3 bucket for uploads"
  value       = aws_s3_bucket.trigger_bucket.bucket
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.s3_event_processor.function_name
}