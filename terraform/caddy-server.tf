resource "aws_instance" "caddy-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name      = "aws_T495_key"

  security_groups = [
    "allow_quic",
    "allow_ssh",
    "allow_https",
    "allow_tests",
  ]

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_instance.caddy-server.public_ip
  }

  provisioner "file" {
    source      = "../stat-server"
    destination = "/home/ubuntu/stat-server"
  }

  provisioner "file" {
    source      = "../caddy/setup.sh"
    destination = "/home/ubuntu/setup.sh"
  }

  provisioner "file" {
    source      = "../caddy/run.sh"
    destination = "/home/ubuntu/run.sh"
  }

  provisioner "file" {
    source      = "../caddy/Caddyfile"
    destination = "/home/ubuntu/Caddyfile"
  }

  provisioner "file" {
    source      = "../install-nix.sh"
    destination = "/home/ubuntu/install-nix.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/setup.sh",
      "chmod +x /home/ubuntu/install-nix.sh",
      "chmod +x /home/ubuntu/run.sh",
      "/home/ubuntu/setup.sh",
    ]
  }

  tags = {
    Name = "caddy-quic-server"
  }
}

resource "aws_eip_association" "caddy_assoc" {
  instance_id   = aws_instance.caddy-server.id
  allocation_id = "eipalloc-084baabcd89983a97"
}

output "caddy_server_ip" {
  description = "Public IP of caddy-server"
  value       = aws_instance.caddy-server.public_ip
}
