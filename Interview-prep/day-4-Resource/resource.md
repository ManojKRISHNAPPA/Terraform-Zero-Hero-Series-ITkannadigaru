# Terraform Resource Dependencies

1. Parallel resource execution
2. Implicit depedency
3. Explicit dependecy
4. Failure handling
5. replaced triggered by metaargument


## Terraform Resource Dependencies
### 1. Parallel resource execution
- creating the multiple resources 
```
resource "aws_s3_bucket" "us-west" {
  bucket = "${var.bucket_name}-${random_string.bucket_prefix-west.result}"
  provider = aws.us-west
}


resource "aws_s3_bucket" "us-east" {
  bucket = "${var.bucket_name}-${random_string.bucket_prefix-us-east.result}"
  provider = aws.us-east
}
```

## 2. Implicit depedency

```
resource "aws_security_group" "web_sg" {
  name = "web-security-group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami           = "ami-0abcdef12345"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

```

## 3. Explicit dependecy

```
resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0abcdef12345"
  instance_type = "t2.micro"

  depends_on = [aws_iam_role_policy_attachment.attach_policy]
}
```

## 4. Upstream Failure Handling

```
resource "aws_db_instance" "database" {
  allocated_storage = 20
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  username          = "admin"
  password          = "wrong-password-format"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0abcdef12345"
  instance_type = "t2.micro"

  depends_on = [aws_db_instance.database]
}

```

# 5. replaced triggered by metaargument

```
resource "aws_launch_template" "web_template" {
  name_prefix   = "web-template"
  image_id      = "ami-0abcdef12345"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "web_asg" {
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$Latest"
  }

  lifecycle {
    replace_triggered_by = [
      aws_launch_template.web_template
    ]
  }
}

```


# META ARGUMENTS:
1. depends_on
2. count and for_each
3. provider
4. lifecyle
    - create_before_destroy
    - prevent_destroy
    - replace_triggerd_by 
    - ignore_changes


