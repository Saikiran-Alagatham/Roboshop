terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "testProvisioner" {
  ami = ""
  instance_type = "t2.micro"

  tags = {
    Name = "testProvisioner"
  }

  provisioner "local-exec" {
      command = "[echo hello, echo world]"
  }
}