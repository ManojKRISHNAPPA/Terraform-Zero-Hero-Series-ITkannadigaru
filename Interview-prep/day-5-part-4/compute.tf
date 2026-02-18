// Source - https://stackoverflow.com/a/63899868
// Posted by Marcin, modified by community. See post 'Timeline' for change history
// Retrieved 2026-02-18, License - CC BY-SA 4.0

data "aws_ami" "ubuntu" {

    most_recent = true

    filter {
        name   = "name"
        values = ["*ubuntu-noble-24.04-amd64-server-*"]

    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    filter {
        name = "architecture"
        values = ["x86_64"]
    }

    owners = ["099720109477"]
}

data "aws_caller_identity" "current" {}


data "aws_region" "current" {}


data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "prod_vpc"{
    tags = {
        Env = "Prod"
    }
}

output "region" {
  value = data.aws_region.current
}

output "azs" {
  value = data.aws_availability_zones.available
} 

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}


output "test" {
  value = data.aws_ami.ubuntu.id
}

output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

resource "aws_instance" "web" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    root_block_device {
      delete_on_termination = true
      volume_size = 8
      volume_type = "gp3"
    }
    tags = {
        Name = "web"
    }
}