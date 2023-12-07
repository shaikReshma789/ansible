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
${aws_instance.server.public_ip }
[backend]
${aws_instance.server-backend.public_ip}
EOF
}

resource "local_file" "linux_playbook" {
  filename = "./linux_playbook.yaml"
  content  = <<EOF
  EOF
  
}

resource "local_file" "ubutu_playbook" {
  filename = "./ubuntu_playbook.yaml"
  content  = "write the playbook for ubuntu"
}

output "frontend" {
    value = aws_instance.server.public_ip
}

output "backed" {
    value = aws_instance.server-backend.public_ip
  
}
