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
    source      = "../caddy/setup.sh"
    destination = "/home/ubuntu/setup.sh"
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
      "/home/ubuntu/setup.sh",
    ]
  }

  tags = {
    Name = "caddy-quic-server"
  }
}

output "caddy_server_ip" {
  description = "Public IP of caddy-server"
  value       = aws_instance.caddy-server.public_ip
}
