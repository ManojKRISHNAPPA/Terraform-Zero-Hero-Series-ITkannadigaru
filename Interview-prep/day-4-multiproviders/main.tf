resource "random_string" "bucket_prefix-west" {
  length = 8
  lower = true
  upper = false
  numeric = true
  special = false
}
resource "random_string" "bucket_prefix-us-east" {
  length = 8
  lower = true
  upper = false
  numeric = true
  special = false
}

resource "aws_s3_bucket" "us-west" {
  bucket = "${var.bucket_name}-${random_string.bucket_prefix-west.result}"
  provider = aws.us-west
}


resource "aws_s3_bucket" "us-east" {
  bucket = "${var.bucket_name}-${random_string.bucket_prefix-us-east.result}"
  provider = aws.us-east
}