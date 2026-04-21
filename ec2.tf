resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "random_id" "key_pair_suffix" {
  byte_length = 3
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.key_pair_name_prefix}-${random_id.key_pair_suffix.hex}"
  public_key = tls_private_key.key.public_key_openssh
}


resource "local_file" "private_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = "${path.module}/deployer-key.pem"
  file_permission = "0600"
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.web_instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = aws_key_pair.deployer.key_name

  user_data = <<-EOF
              #!/bin/bash
              set -euxo pipefail

              # Install Docker on Amazon Linux 2
              yum update -y
              amazon-linux-extras install -y docker
              yum install -y docker

              # Start and enable Docker service
              systemctl enable docker
              systemctl start docker

              # Allow ec2-user to run Docker commands without sudo
              usermod -aG docker ec2-user
              EOF

  tags = {
    Name = "nginx-server"
  }
}