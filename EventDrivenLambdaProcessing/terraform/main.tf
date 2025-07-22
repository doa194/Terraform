
resource "aws_s3_bucket" "trigger_bucket" { # Create an S3 bucket to trigger the Lambda function
  bucket = var.s3_bucket_name
  force_destroy = true # Allow bucket to be destroyed even if it contains objects

  tags = {
    Name = var.s3_bucket_name
  }
}

resource "aws_iam_role" "lambda_exec_role" { 
# Create an IAM role for the Lambda function 
# This role allows the Lambda function to assume the necessary permissions
  name = "${var.lambda_function_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole", # Allow Lambda to assume this role
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "s3_access" { 
  ## Attach a policy to the Lambda role to allow access to the S3 bucket
  name = "lambda-s3-access"
  role = aws_iam_role.lambda_exec_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.trigger_bucket.arn,
          "${aws_s3_bucket.trigger_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_lambda_function" "s3_event_processor" {
  # Create the Lambda function that will process S3 events
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "S3EventProcessor::S3EventProcessor.Function::FunctionHandler"
  runtime       = "dotnet6"
  filename      = "../lambda/S3EventProcessor/publish/lambda.zip"
  timeout       = 30
  source_code_hash = filebase64sha256("../lambda/S3EventProcessor/publish/lambda.zip")

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.trigger_bucket.bucket
    }
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.trigger_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_event_processor.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_event_processor.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.trigger_bucket.arn
}