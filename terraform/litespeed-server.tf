resource "aws_instance" "litespeed-server" {
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
    host = aws_instance.litespeed-server.public_ip
  }

  provisioner "file" {
    source      = "../litespeed/setup.sh"
    destination = "/home/ubuntu/setup.sh"
  }

  provisioner "file" {
    source      = "../litespeed/run.sh"
    destination = "/home/ubuntu/run.sh"
  }

  provisioner "file" {
    source      = "../litespeed/ols.conf"
    destination = "/home/ubuntu/ols.conf"
  }

  provisioner "file" {
    source      = "../litespeed/vhconf.conf"
    destination = "/home/ubuntu/vhconf.conf"
  }

  provisioner "file" {
    source      = "../litespeed/httpd_config.conf"
    destination = "/home/ubuntu/httpd_config.conf"
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
    Name = "litespeed-quic-server"
  }
}

resource "aws_eip_association" "litespeed_assoc" {
  instance_id   = aws_instance.litespeed-server.id
  allocation_id = "eipalloc-0a89cd244add538a4"
}

output "litespeed_server_ip" {
  description = "Public IP of litespeed-server"
  value       = aws_instance.litespeed-server.public_ip
}
