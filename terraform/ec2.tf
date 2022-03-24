resource "aws_instance" "server" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t2.medium"
  key_name             = "aws_T495_key"

  security_groups = ["allow_quic"]

  provisioner "file" {
    source      = "../nginx/install-nginx.sh"
    destination = "/home/ubuntu/install-nginx.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.server.public_dns
    }
  }

  provisioner "file" {
    source      = "../nginx/shell.nix"
    destination = "/home/ubuntu/shell.nix"
    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.server.public_dns
    }
  }

  // provisioner "file" {
  //   source      = "../nginx/nginx.conf"
  //   destination = "/home/ubuntu/.local/opt/nginx/conf/nginx.conf"
  //   connection {
  //     type = "ssh"
  //     user = "ubuntu"
  //     host = aws_instance.server.public_dns
  //   }
  // }

  tags = {
    Name = "quic-perf-server"
  }
}

output "instance_public_dns" {
  description = "Public DNS of server"
  value       = aws_instance.server.public_dns
}
