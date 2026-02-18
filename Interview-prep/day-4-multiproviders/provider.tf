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
  alias = "us-west"
}

provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
  alias = "us-east"
}