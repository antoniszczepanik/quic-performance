resource "aws_instance" "client" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name      = "aws_T495_key"

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_instance.client.public_ip
  }

  provisioner "file" {
    source      = "../nginx/install-nix.sh"
    destination = "/home/ubuntu/install-nix.sh"
  }


  provisioner "remote-exec" {
    inline = [
      // First things first.
      "echo 'set -o vi' >> .profile",
      // Install nix.
      "chmod +x /home/ubuntu/install-nix.sh",
      "/home/ubuntu/install-nix.sh",
      "sudo sysctl -w net.core.rmem_max=2500000", // https://github.com/lucas-clemente/quic-go/wiki/UDP-Receive-Buffer-Size
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
