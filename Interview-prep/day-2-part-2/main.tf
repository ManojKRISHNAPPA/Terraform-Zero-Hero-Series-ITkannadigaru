resource "random_string" "bucket_prefix" {
  length = 8
  lower = true
  upper = false
  numeric = true
  special = false
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "${var.bucket_name}-${random_string.bucket_prefix.result}"
}
