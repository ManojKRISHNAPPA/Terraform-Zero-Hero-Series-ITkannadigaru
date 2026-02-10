terraform {
  required_version = "~> 1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = ""
  secret_key = ""
  alias      =  "us-west"
}

provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
  alias      = "us-east"
}



resource "aws_s3_bucket" "us-west-2" {
  bucket   = "some-random-bucket-itkannadigaru-on-us-west"
  provider = aws.us-west
}

resource "aws_s3_bucket" "us-west-1" {
  bucket   = "some-random-bucket-itkannadigaru-on-us-east"
  provider = aws.us-east
}
