output "static_webhosting_endPoint" {
  value = aws_s3_bucket_website_configuration.static_webhosting.website_endpoint
}