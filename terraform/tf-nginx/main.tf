provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "nginx_sg" {
  name_prefix = "nginx-sg"

  tags = {
    Name = "nginx-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "nginx_tcp_ingress" {
  security_group_id = aws_security_group.nginx_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "nginx_ssh_ingress" {
  security_group_id = aws_security_group.nginx_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "nginx_egress" {
  security_group_id = aws_security_group.nginx_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_key_pair" "nginx_key_pair" {
  key_name   = "wrights-ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+8pADEYbTYB8DI9myCnAk59QuRw6W8RsFZ3UgwmYidLhSjlY1DuWqzeaMEc2Otday9QprsrbCcGTh00l2S8GlOGsDr7VHcoYtQVNroPhqAHKY0jvTUifejjRUHsD4Myw0S0duY8PdKKz0XZDRDhFuSsdIALOjZMMN705xkt7GU3RIuLccKNnEPXAZ0Jn56tgWXl+Yx+E9VmsT4jFYhEDwK+VS6S+vM3oUGAT5eUloyBUArrEn9F238J90lO1Y5p9Z/edWXdk0edZbXxrvpnPMVK/OeFNx37Y/AdlhQleHWoU9nKMALJnz5pVWPR+TuewZ3wwAcTDgHb0AeUy8mSyR mac@MACs-MBP"
}

resource "aws_instance" "nginx_server" {
  ami           = "ami-0427090fd1714168b" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  security_groups = [aws_security_group.nginx_sg.name]

  tags = {
    Name = "nginx-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install nginx -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  # Ensure the instance has access to the internet and can be accessed
  associate_public_ip_address = true
  key_name                    = aws_key_pair.nginx_key_pair.key_name
}

output "nginx_public_ip" {
  value = aws_instance.nginx_server.public_ip
}
