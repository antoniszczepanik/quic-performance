resource "aws_instance" "nginx-server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name      = "aws_T495_key"

  security_groups = ["allow_quic"]

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

  provisioner "remote-exec" {
    inline = [
      // First things first.
      "echo 'set -o vi' >> .profile",
      // Install nix.
      "chmod +x /home/ubuntu/install-nix.sh",
      "/home/ubuntu/install-nix.sh",
      // Compile nginx.
      ". /home/ubuntu/.profile", // Adds nix to PATH.
      "chmod +x /home/ubuntu/install-nginx.sh",
      "/home/ubuntu/install-nginx.sh",
      "sudo mv nginx-quic-55b38514729b/objs/nginx /usr/local/bin/nginx",
    ]
  }

  provisioner "file" {
    source      = "../nginx/nginx.conf"
    destination = "/home/ubuntu/.local/opt/nginx/conf/nginx.conf"
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
