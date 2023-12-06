resource "aws_instance" "server" {
  ami           = "ami-080d1454ad4fabd12"
  instance_type = "t2.micro"
  key_name      = "cats1"
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname C8.local
              EOF
  tags = {
    Name = "C8.local"
  }
}
resource "aws_instance" "server-backend" {
  ami           = "ami-0da7657fe73215c0c"
  instance_type = "t2.micro"
  key_name      = "cats1"
    user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname U21.local
              EOF
  tags = {
    Name = "U21.local"
  }
}
resource "local_file" "inventory" {
  filename = "./inventory.yaml"
  content  = <<EOF
[frontend]
$ {aws_instance.server }
[backend]
$ {aws_instance.server-backend}
EOF
}


