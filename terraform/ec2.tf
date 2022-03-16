resource "aws_instance" "server" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t2.medium"
  key_name             = "aws_T495_key"

  provisioner "file" {
    source      = "install-nginx.sh"
    destination = "/home/ubuntu/install-nginx.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.server.public_dns
    }
  }

  provisioner "file" {
    source      = "shell.nix"
    destination = "/home/ubuntu/shell.nix"
    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.server.public_dns
    }
  }

  tags = {
    Name = "quic-perf-server"
  }
}

output "instance_public_dns" {
  description = "Public IP of server"
  value       = aws_instance.server.public_dns
}
