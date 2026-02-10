# auto generate bucket id
resource "random_string" "bucket_prefix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = true
  special = false
}

# it will create s3 bucket
resource "aws_s3_bucket" "static_webhosting" {
  bucket = "${var.bucket_name}-${random_string.bucket_prefix.result}"
}

# it will create s3 bucket public access bucket level
resource "aws_s3_bucket_public_access_block" "static_webhosting" {
  bucket                  = aws_s3_bucket.static_webhosting.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# it helps you to create account level access
resource "aws_s3_account_public_access_block" "allow_public" {

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# bucket am giving s3 policy
resource "aws_s3_bucket_policy" "static_website_public_read" {
  bucket = aws_s3_bucket.static_webhosting.id

  depends_on = [
    aws_s3_account_public_access_block.allow_public
  ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_webhosting.arn}/*"
      }
    ]
  })
}

# this helps website condifguration
resource "aws_s3_bucket_website_configuration" "static_webhosting" {
  bucket = aws_s3_bucket.static_webhosting.id
  index_document {
    suffix = "index.html"
  }
}

# this helps to copy content to s3 bucket
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_webhosting.id
  key          = "index.html"
  source       = "code/index.html"
  etag         = filemd5("code/index.html")
  content_type = "text/html"
}


