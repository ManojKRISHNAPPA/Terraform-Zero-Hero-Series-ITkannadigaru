terraform {
  required_version = "~> 1.14"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
    random ={
        source = "hashicorp/random"
        version = "~> 3.0"
    }
    backend = {
        source = "hashicorp/vault"
        version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  access_key = ""
  secret_key = ""
}


data "aws_secretsmanager_secret" "mysecret" {
    name = ""
    arn = ""
    # its not managed by terraform
}

variable "bucket_name" {
  type = "string"
  description = "pupose of this bucket"
  default = "mybucket-123"
}

output "bucket_id" {
  value = aws_s3_bucket.mybucket-123.id
}

locals {
  locals_example = "common_variables"
}

resource "aws_s3_bucket" "mybucket-123" {
  bucket = var.bucket_name
  tags = {
    Name = ""
  }
}

module "my-vpc" {
  source = "./vpc"
}