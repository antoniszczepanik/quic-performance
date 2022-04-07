variable "GCLOUD_STACK_ID" {
  type        = string
  description = "Graphana stack ID"
  //sensitive   = true
}

variable "GCLOUD_API_KEY" {
  type        = string
  description = "Graphana API KEY"
  //sensitive   = true
}

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
      // Install graphana
      "wget https://raw.githubusercontent.com/grafana/agent/release/production/grafanacloud-install.sh",
      "chmod +x grafanacloud-install.sh",
      "sudo ARCH=amd64 GCLOUD_STACK_ID='${var.GCLOUD_STACK_ID}' GCLOUD_API_KEY='${var.GCLOUD_API_KEY}' GCLOUD_API_URL='https://integrations-api-eu-west.grafana.net' ./grafanacloud-install.sh", 
    ]
  }

  provisioner "file" {
    source      = "../nginx/nginx.conf"
    destination = "/home/ubuntu/.nginx/conf/nginx.conf"
  }

  provisioner "file" {
    source      = "../nginx/grafana-agent.yaml"
    destination = "/home/ubuntu/grafana-agent.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo nginx",
      "sudo mv /home/ubuntu/grafana-agent.yaml /etc/grafana-agent.yaml",
      "sudo systemctl restart grafana-agent.service"
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
