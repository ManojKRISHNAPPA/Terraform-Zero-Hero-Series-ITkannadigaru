terraform {
  required_version = "~> 1.5.7"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
    random ={
        source = "hashicorp/random"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  access_key = ""
  secret_key = ""
}


# resource "random_id" "bucket_prefix" {
#   byte_length = 6
# }


resource "random_string" "bucket_prefix" {
  length = 8
  lower = true
  upper = false
  numeric = true
  special = false
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "itkannadigaru-${random_string.bucket_prefix.result}"
}

