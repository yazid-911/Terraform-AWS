locals {
  jeu_files = fileset(path.module, "jeu/**")
}

resource "null_resource" "deploy_jeu" {
  count = length(local.jeu_files) > 0 ? 1 : 0

  depends_on = [aws_instance.web]

  triggers = {
    instance_id = aws_instance.web.id
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.key.private_key_pem
    host        = aws_instance.web.public_ip
  }

  provisioner "file" {
    source      = "${path.module}/jeu"
    destination = "/home/ec2-user/jeu"
  }

  provisioner "remote-exec" {
    inline = [
      "while ! sudo systemctl is-active --quiet docker; do sleep 5; done",
      "cd /home/ec2-user/jeu",
      "sudo docker build -t jeu-pong .",
      "sudo docker rm -f pong || true",
      "sudo docker run -d -p 80:80 --name pong jeu-pong"
    ]
  }
}
