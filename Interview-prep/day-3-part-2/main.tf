resource "aws_instance" "myec2" {
  ami           = "ami-055a9df0c8c9f681c"
  instance_type = "t3.micro"
  tags = {
    Name = var.instance_name
  }
}

import {
  to = aws_instance.myec2
  id = "i-08ed23b7eff9f19ef"
}