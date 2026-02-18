resource "aws_instance" "web" {
    count = 10
    ami = "ami-0c1fe732b5494dc14"
    instance_type = "t3.micro"

    tags = {
        Name = "web-${count.index}"
    }
}