resource "aws_instance" "client" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name      = "aws_T495_key"


  security_groups = [
    "allow_ssh",
    "allow_tcp_8080",
  ]

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_instance.client.public_ip
  }

  provisioner "file" {
    source      = "../install-nix.sh"
    destination = "/home/ubuntu/install-nix.sh"
  }

  provisioner "file" {
    source      = "../client/analysis.ipynb"
    destination = "/home/ubuntu/analysis.ipynb"
  }

  provisioner "file" {
    source      = "../client/shell.nix"
    destination = "/home/ubuntu/shell.nix"
  }

  provisioner "file" {
    source      = "../client/run-notebook.sh"
    destination = "/home/ubuntu/run-notebook.sh"
  }

  provisioner "file" {
    source      = "../client/run.sh"
    destination = "/home/ubuntu/run.sh"
  }

  provisioner "file" {
    source      = "../client/setup.sh"
    destination = "/home/ubuntu/setup.sh"
  }

  provisioner "file" {
    source      = "../client/compile-nghttp2.sh"
    destination = "/home/ubuntu/compile-nghttp2.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/setup.sh",
      "chmod +x /home/ubuntu/install-nix.sh",
      "chmod +x /home/ubuntu/run-notebook.sh",
      "chmod +x /home/ubuntu/compile-nghttp2.sh",
      "chmod +x /home/ubuntu/run.sh",
      "/home/ubuntu/compile-nghttp2.sh",
      "/home/ubuntu/setup.sh",
    ]
  }

  tags = {
    Name = "quic-client"
  }
}

output "client_ip" {
  description = "Public IP of client"
  value       = aws_instance.client.public_ip
}
