#THIS AUTO GENEATES BUCKETS SUFFIX ID
resource "random_string" "bucket_prefix-west" {
  length  = 8
  lower   = true
  upper   = false
  numeric = true
  special = false
}

# THIS WILL CREATE BUCKET
resource "aws_s3_bucket" "static_webhosting" {
  bucket = "${var.bucket_name}-${random_string.bucket_prefix-west.result}"
}

# NEED CREATE S3 BUCKET TO PUBLIC ACCESS

resource "aws_s3_bucket_public_access_block" "webhosting" {
  bucket                  = aws_s3_bucket.static_webhosting.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# bucket policy creation
resource "aws_s3_bucket_policy" "static_webhosting_public_read" {
  bucket = aws_s3_bucket.static_webhosting.id

  depends_on = [
    aws_s3_bucket_public_access_block.webhosting
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

# website configuration:

resource "aws_s3_bucket_website_configuration" "static_webhosting" {
  bucket = aws_s3_bucket.static_webhosting.id
  index_document {
    suffix = "index.html"
  }
}


# copying my local code to s3

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_webhosting.id
  key          = "index.html"
  source       = "code/index.html"
  etag         = filemd5("code/index.html")
  content_type = "text/html"

}
