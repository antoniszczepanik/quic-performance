resource "aws_instance" "nginx-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name      = "aws_T495_key"

  security_groups = [
    "allow_quic",
    "allow_ssh",
    "allow_https",
  ]

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_instance.nginx-server.public_ip
  }

  provisioner "file" {
    source      = "../nginx/install-nix.sh"
    destination = "/home/ubuntu/install-nix.sh"
  }


  provisioner "file" {
    source      = "../nginx/install-nginx.sh"
    destination = "/home/ubuntu/install-nginx.sh"
  }

  provisioner "file" {
    source      = "../nginx/shell.nix"
    destination = "/home/ubuntu/shell.nix"
  }

  provisioner "file" {
    source      = "../nginx/setup.sh"
    destination = "/home/ubuntu/setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      // Run setup script.
      "chmod +x /home/ubuntu/setup.sh",
      "chmod +x /home/ubuntu/install-nix.sh",
      "chmod +x /home/ubuntu/install-nginx.sh",
      "/home/ubuntu/setup.sh",
    ]
  }

  provisioner "file" {
    source      = "../nginx/nginx.conf"
    destination = "/home/ubuntu/.nginx/conf/nginx.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo nginx",
    ]
  }

  tags = {
    Name = "nginx-quic-server"
  }
}

output "nginx_server_ip" {
  description = "Public IP of nginx-server"
  value       = aws_instance.nginx-server.public_ip
}
