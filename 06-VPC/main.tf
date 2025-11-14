provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Terraform-VPC"
  }
}

resource "aws_subnet" "mysub" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
    tags = {
        Name = "Terraform-sub"
    }
}