resource "aws_instance" "h2o-server" {
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
    host = aws_instance.h2o-server.public_ip
  }

  provisioner "file" {
    source      = "../stat-server"
    destination = "/home/ubuntu/stat-server"
  }

  provisioner "file" {
    source      = "../h2o/setup.sh"
    destination = "/home/ubuntu/setup.sh"
  }

  provisioner "file" {
    source      = "../h2o/run.sh"
    destination = "/home/ubuntu/run.sh"
  }

  provisioner "file" {
    source      = "../h2o/h2o.config"
    destination = "/home/ubuntu/h2o.config"
  }

  provisioner "remote-exec" {
    inline = [
      // Run setup script.
      "chmod +x /home/ubuntu/setup.sh",
      "chmod +x /home/ubuntu/run.sh",
      "/home/ubuntu/setup.sh",
    ]
  }

  tags = {
    Name = "h2o-quic-server"
  }
}

resource "aws_eip_association" "h2o_assoc" {
  instance_id   = aws_instance.h2o-server.id
  allocation_id = "eipalloc-0e0d242bef827c9b8"
}


output "h2o_server_ip" {
  description = "Public IP of h2o-server"
  value       = aws_instance.h2o-server.public_ip
}
