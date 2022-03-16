terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "aws_T495_key" {
  key_name   = "aws_T495_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjAHAkM+ZuaAeq5Bt5uUoWy6IDTov4vkr7StTSAOl/CPOD0uA2OvS5rMHwSc1HOhW9rXk4O2rr33AnY7UsfdhCWaQsxYA5yxRB9cQJP5CbFfYykQOuzXpuzhAbaDf/sqxlO9se0IB/7qkEDSzK8drtiiGthmQEOOAgg42HqIVpOHqL17MCL2UdU+qvXDBbfpFWS+C//TD0Fy4K2qhRvsXpMvT8uNAmZJf45ks5C/o+1VjSEQPyoF0DOS13eXnomvoRblCWjJ420Cvt296d5VbSJVlEC8yTmoqEDPqN0wnsCBwotNF0ZyZ/SJWTkJSQvohEx3GEePV20iZvdXNrV/keQ80vffUH2SbQvKi7dmrGKg8n69HDCWNBFW//pi8hvKOpjK4jCSsYr/madiSsdk+oqnknCpSoZtgI0LCb2N3ZFLZ/W+oIYCyv+OW3deZ6Z+M/2EKakVyfJQb13CwBrUodI5cwwJb/uxn2Mf7RAxeSfm91inW1jt05dpqrCTUwxmE= antoni@antoni-T495"
}
