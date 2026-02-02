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
  backend "s3" {
    bucket     = "manoj-fw0bq0fo"
    key        = "prod/terraform.tfstate"
    region     = "us-west-2"
    access_key = ""
    secret_key = ""
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = ""
  secret_key = ""
}
